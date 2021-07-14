import 'package:pon/locator.dart';
import 'package:pon/services/preference_service.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPaymentGateway {
  Razorpay _razorpay;

  Function(PaymentSuccessResponse) _onPaymentSuccess;
  Function(PaymentFailureResponse) _onPaymentFailure;
  Function(ExternalWalletResponse) _onExternalWalletResponse;

  RazorpayPaymentGateway(this._onPaymentSuccess, this._onPaymentFailure,
      this._onExternalWalletResponse) {
    _razorpay = new Razorpay();
  }

  open(double amount, String paymentMethod) async {
    int razorpayAmount = (amount * 100).toInt();
    var options = {
      'key': 'rzp_live_suMgviF9NJn0Ia',
      'amount': razorpayAmount,
      'payAmount': amount,
      'name': 'Rasi Mart',
      'description': locator<PreferenceService>().getName(),
      'prefill': {
        'contact': locator<PreferenceService>().getPhoneNo(),
        'method': paymentMethod.toString(),
      },
      'readonly': {"email": true, "contact": true, 'method': true},
      'method': {
        'card': paymentMethod.toLowerCase() == "card",
        'upi': paymentMethod.toLowerCase() == "upi",
        'netbanking': paymentMethod.toLowerCase() == "netbanking",
        'emi': paymentMethod.toLowerCase() == "emi",
        'wallet': paymentMethod.toLowerCase() == "wallet",
        'cardless_emi': paymentMethod.toLowerCase() == "cardless_emi",
        'paylater': paymentMethod.toLowerCase() == "paylater",
        'emandate': paymentMethod.toLowerCase() == "emandate",
      }
    };

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _onPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _onPaymentFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _onExternalWalletResponse);

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e);
    }
  }
}
