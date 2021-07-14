class ApiMethod {
  static const String POST = "POST";
  static const String GET = "GET";
  static const String PUT = "PUT";
}

class ApiEndpoint {
  static String _endPointBase = "service.php?api=";

  static String driverdetails = _endPointBase + "driverdetails";
  static String enquiry = _endPointBase + "enquiry";
  static String getenquiry = _endPointBase + "getenquiry";
}
