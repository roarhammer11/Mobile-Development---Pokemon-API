import 'package:flutter/material.dart';
import 'components/custom_text_form_field.dart';
import 'components/password_field.dart';
import 'components/primary_button.dart';
import 'homepage.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final myController = TextEditingController();
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                CustomTextFormField(
                    labelText: "Email Address",
                    hintText: "Enter a valid email",
                    iconData: Icons.email,
                    textInputType: TextInputType.emailAddress,
                    controller: myController),
                const SizedBox(
                  height: 20.0,
                ),
                PasswordField(
                    labelText: "Password",
                    hintText: "Enter your password",
                    obscureText: obscureText,
                    onTap: setPasswordVisibility),
                const SizedBox(
                  height: 20.0,
                ),
                PrimaryButton(
                    text: "Login", iconData: Icons.login, onPressed: login),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context); //Ensures that context is empty when logging in
    }
    Navigator.pushReplacementNamed(context, Homepage.routeName);
  }

  void setPasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
