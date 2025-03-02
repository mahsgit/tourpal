import 'package:flutter/material.dart';

class VrPage extends StatelessWidget {
  const VrPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('VR Experience')),
      body: Center(
        child: const Text('VR Page Content goes here'),
      ),
    );
  }
}
