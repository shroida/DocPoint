import 'package:docpoint/core/widgets/app_snackbar.dart';
import 'package:docpoint/features/payment/stripe_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  bool _loading = false;

  Future<void> _makePayment() async {
    try {
      setState(() => _loading = true);

      // Create a PaymentIntent
      final paymentIntent = await StripeService.createPaymentIntent(
        amount: '1000',
        currency: 'usd',
      );

      // Initialize the Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: 'Walied Store',
        ),
      );

      // Present the Payment Sheet
      await Stripe.instance.presentPaymentSheet();
      if (mounted) {
        showAppSnackBar(
            message: "Payment successful!",
            context: context,
            backgroundColor: Colors.green);
      }
    } catch (e) {
      if (mounted) {
        showAppSnackBar(
            context: context,
            message: "Error ${e.toString()}",
            backgroundColor: Colors.red);
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stripe Payment")),
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _makePayment,
                child: const Text("Pay Now \$10"),
              ),
      ),
    );
  }
}
