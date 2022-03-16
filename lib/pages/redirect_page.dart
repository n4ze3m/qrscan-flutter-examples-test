import 'package:flutter/material.dart';

class RedirectPage extends StatelessWidget {
  const RedirectPage({Key? key, required this.barcode}) : super(key: key);
  final String barcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(barcode),
      ),
    );
  }
}
