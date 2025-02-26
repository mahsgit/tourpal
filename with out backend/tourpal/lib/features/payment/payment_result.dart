import 'package:flutter/material.dart';

class PaymentResultPage extends StatelessWidget {
  const PaymentResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Result'),
      ),
      body: Center(
        child: Text('Payment process completed. Check your console for details.'),
      ),
    );
  }
}

