import 'package:flutter/material.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key, required this.token});

  final String token;

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm email"),
      ),
      body: Center(
        child: Text("${widget.token}"),
      ),
    );
  }
}
