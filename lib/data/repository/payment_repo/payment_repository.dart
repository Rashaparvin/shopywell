import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shopywell/core/strings/api_keys.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentRepository {
  Future<void> makePayment(int amount) async {
    try {
      String? paymentIntentClientSecret =
          await _createPaymentIntent(amount, 'usd');
      if (paymentIntentClientSecret == null) {
        return;
      }
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: 'Rasha',
        ),
      );
      await _processPayment();
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        'amount': _calculateAmount(
          amount,
        ),
        'currency': currency,
      };
      final response =
          await dio.post('https://api.stripe.com/v1/payment_intents',
              data: data,
              options: Options(
                contentType: Headers.formUrlEncodedContentType,
                headers: {
                  'Authorization': 'Bearer $stripeSecretKey',
                  'Content-Type': 'application/x-www-form-urlencoded'
                },
              ));
      log('------${response.data}');
      if (response.data != null) {
        return response.data['client_secret'];
      }
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print(e);
    }
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}
