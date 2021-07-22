import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

class StripeTransactionResponse {
  String message ;
  bool success ;
  StripeTransactionResponse({
    this.message,this.success
});
}

class StripeService {
  static String apiBase = 'http://api.Stripe.com/v1';
  static Uri paymentApiUri = Uri.parse('${StripeService.apiBase}/payment_intent');
  static String secret = 'sk_test_51J6tpuDrZN4ysegZ5JW204RJIa9Rb4KSHVgurX0m4gzFnDctKLV7SwV9puncsDyTKXTeiQd7sdM1tsmt1OhxNjwR000C5WGFWh';
  static Map<String, Object> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-type': 'application/x-www-urlencoded',
  };
  static getPlatformExceptionResult(err){
    String message = 'Something went wrong';
    if(err.code == 'canceled'){
      message = 'Transaction Canceled ';
    }
    return StripeTransactionResponse(message: message,success: false);
  }
  static init() {
    StripePayment.setOptions(StripeOptions(
      publishableKey: 'pk_test_51J6tpuDrZN4ysegZcmzV7rn5EX36S4D03XB6iJBAwjK6crdPN9QiRZSFEimjn4vxnc8A0999IrmTQG4J9W4euiyw00ZhsSDkq7',
      merchantId: 'test',
      androidPayMode: 'test',
    ),
    );
  }

  static Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency)async {
    try{
       Map<String, Object> body = {
        'amount': amount,
        'currency': currency,
      };
       var response = await http.post(paymentApiUri,headers:headers,body: body,);
       return jsonDecode(response.body);
    }catch(error){
      print('Error payment $error');
    }
  return null;
  }
  static Future<StripeTransactionResponse>payWithNewCard({String amount, String currency})async{
    try{
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest());
      var paymentIntent = await StripeService.createPaymentIntent(amount, currency);
      var response = await StripePayment.
      confirmPaymentIntent(PaymentIntent(clientSecret: paymentIntent['client_secret'] ,
      paymentMethodId: paymentMethod.id));
      if (response.status == 'succeeded'){
        return StripeTransactionResponse(message: 'Succeeded',success: true);
      }else{
        return StripeTransactionResponse(message: 'Failed', success: false);
      }
    }on PlatformException catch(error){
      return StripeService.getPlatformExceptionResult(error);
    }catch(error){
      return StripeTransactionResponse(message: 'Failed $error', success: false);
    }
  }
}
