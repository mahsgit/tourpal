import 'package:flutter/material.dart';
import 'package:chapasdk/chapasdk.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Pay with Chapa'),
          onPressed: () => _initiatePayment(context),
        ),
      ),
    );
  }

  void _initiatePayment(BuildContext context) {
    // Generate a unique transaction reference
    String txRef = 'tx_${DateTime.now().millisecondsSinceEpoch}';

    Chapa.paymentParameters(
      context: context,
      publicKey: 'CHAPUBK_TEST-XXXXXXXX', // Replace with your actual public key
      currency: 'ETB',
      amount: '100', // Amount in ETB
      email: 'merbebtsolomon@gmail.com',
      firstName: 'John',
      lastName: 'Doe',
      txRef: txRef,
      title: 'Payment for Tour',
      desc: 'Tour package payment',
      namedRouteFallBack: '/payment-result',
      nativeCheckout: true, // Set to false for web checkout
      onPaymentFinished: (message, reference, amount) {
        // Handle the payment result
        print('Payment finished: $message, Reference: $reference, Amount: $amount');
        // You can navigate to a result page or show a dialog here
      }, phone: '',
    );
  }
}

