import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StripeService {
  static const String _publishableKey = 'pk_test_TYooMQauvdEDq54NiTphI7jx';
  static const String _secretKey = String.fromEnvironment('STRIPE_SECRET_KEY');

  // Initialize Stripe
  static Future<void> init() async {
    Stripe.publishableKey = _publishableKey;
    Stripe.merchantIdentifier = 'merchant.com.yourapp';
    await Stripe.instance.applySettings();
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      {required String amount, required String currency}) async {
    try {
      final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $_secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'amount': amount,
          'currency': currency,
          'payment_method_types[]': 'card',
        },
      );

      return json.decode(response.body);
    } catch (err) {
      throw Exception('Error creating PaymentIntent: $err');
    }
  }

  // Initialize payment sheet
  static Future<void> initPaymentSheet({
    required String clientSecret,
    required String customerId,
    required String ephemeralKey,
  }) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Your App Name',
          customerId: customerId,
          customerEphemeralKeySecret: ephemeralKey,
          style: ThemeMode.system,
        ),
      );
    } catch (e) {
      throw Exception('Failed to initialize payment sheet: $e');
    }
  }

  // Display the payment sheet
  static Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } on Exception catch (e) {
      throw Exception('Payment failed: $e');
    }
  }
}
