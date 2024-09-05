import 'package:flutter/material.dart';

class FinancePayment extends StatefulWidget {
  const FinancePayment({super.key});

  @override
  State<FinancePayment> createState() => _FinancePaymentState();
}

class _FinancePaymentState extends State<FinancePayment> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('FinancePayment'),
      ),
    );
  }
}
