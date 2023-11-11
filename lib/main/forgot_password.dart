import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  static const String routeName = "forgotpassword";

  const ForgotPassword({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: const Center(
        child: Text("This is the Forgot Password."),
      ),
    );
  }
}
