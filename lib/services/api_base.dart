import 'dart:convert';
import 'package:pon/router.dart';
import 'package:pon/services/navigation_service.dart';
import 'package:pon/services/secure_storage.dart';
import 'package:http/http.dart';
import 'package:pon/core/models/api_error_response.dart';
import 'package:pon/core/models/api_exceptions.dart';
import 'package:pon/locator.dart';
import 'package:pon/services/dialog_service.dart';
class ApiBase {
  var client = new Client();
  
  final SecureStorage _secureStorage = locator<SecureStorage>();

  // SERIALIZE & ASYNC FUNCTION
  String serialize(Object obj) {
    String serialized = '';
    if (obj == null) {
      serialized = '';
    } else {
      serialized = json.encode(obj);
    }
    return serialized;
  }

  Future<Response> sendAsync(String method, String path, Object body,
      {bool authentication = false}) async {
    String baseUrl = "http://srirasiagency.com/travelsapi/";
    //String baseUrl = "http://localhost:8080/api/";

    var url = Uri.parse(baseUrl + path);
    var requestMessage = Request(method, url);
    Map<String, String> headerParams = {};
    try {
      if (body != null) {
        if (body is String) {
          headerParams["Content-Type"] = "application/x-www-form-urlencoded";
          requestMessage.body = body;
        } else if (body is MultipartRequest) {
          headerParams['Accept'] = "application/json";
        } else {
          headerParams['Accept'] = "application/json";
          headerParams["Content-Type"] = "application/json";
          requestMessage.body = serialize(body);
        }
      }

//      headerParams["User-Agent"] =  await _deviceService.getUserAgent();
//      headerParams['OG-Device-Id'] =  await _deviceService.getDeviceId();
//      headerParams['OG-User'] = await _getUserInfo();

      if (authentication) {
        headerParams['authorization'] = await _secureStorage.getAccessToken();
       
      }

//      if(path.contains("login")){
//        headerParams.addAll( await _deviceService.getDeviceInfoHeaders());
//      }

      requestMessage.headers.addAll(headerParams);
      Response response;
      try {
        if (body is MultipartRequest) {
          body.headers.addAll(headerParams);
          response = await Response.fromStream(await client.send(body));
        } else {
          response =
              await Response.fromStream(await client.send(requestMessage));
        }
      } catch (e) {
        var error = ApiException(_handleConnectionError());
        if ((error != null && error.error != null)) {
          if (error.error.getSingleMessage() != null) {
            locator<DialogService>()
                .showDialog(description: error.error.getSingleMessage());
          }
        }
      }
      if (response != null) {
        if (response.statusCode == 200) {
          return response;
        } else if (response.statusCode >= 400) {
          var error = await _handleApiError(response, false);
          if (error != null) {
            if (error.getSingleMessage() != null) {
              locator<DialogService>()
                  .showDialog(description: error.getSingleMessage());
            }
          }
        }
      }
      return null;
    } finally {}
  }

  ErrorResponse _handleConnectionError() {
    var result = new ErrorResponse();
    result.statusCode = 502;
    result.message = "There is a problem connecting to the server.";
    return result;
  }

  Future<ErrorResponse> _handleApiError(
      Response response, bool tokenError) async {
    //TokenError and BadRequest || Forbidden || UnAuthorized
    if ((tokenError && response.statusCode == 400) ||
        response.statusCode == 403 ||
        response.statusCode == 401) {
      await locator<DialogService>().showDialog(
        title: "Authentication Failed",
      );
      
      _secureStorage.clearToken();
      locator<NavigationService>().popAllAndPushNamed(Routes.custledger);
      return null;
    }

    Map<String, Object> responseJObject;
    if (_isJsonResponse(response)) {
      responseJObject = json.decode(response.body);
    }
    return ErrorResponse.fromResponse(
        responseJObject, response.statusCode, tokenError);
  }

  bool _isJsonResponse(Response response) {
    return (response.headers["content-type"]?.contains("json"));
  }
}
