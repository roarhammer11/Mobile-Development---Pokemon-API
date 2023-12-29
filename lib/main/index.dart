import 'package:flutter/material.dart';
import 'components/custom_text_form_field.dart';
import 'components/password_field.dart';
import 'components/primary_button.dart';
import 'homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Index extends StatefulWidget {
  static const String routeName = "login";
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  final myController = TextEditingController();
  bool obscureText = true;
  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Scaffold(
  //       body: Container(
  //         alignment: Alignment.topCenter,
  //         margin: const EdgeInsets.only(top: 160.0),
  //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //         child: SingleChildScrollView(
  //           child: Column(
  //             children: [
  //               const SizedBox(
  //                 height: 20.0,
  //               ),
  //               CustomTextFormField(
  //                   labelText: "Email Address",
  //                   hintText: "Enter a valid email",
  //                   iconData: Icons.email,
  //                   textInputType: TextInputType.emailAddress,
  //                   controller: myController),
  //               const SizedBox(
  //                 height: 20.0,
  //               ),
  //               PasswordField(
  //                   labelText: "Password",
  //                   hintText: "Enter your password",
  //                   obscureText: obscureText,
  //                   onTap: setPasswordVisibility),
  //               const SizedBox(
  //                 height: 20.0,
  //               ),
  //               PrimaryButton(
  //                   text: "Login", iconData: Icons.login, onPressed: login),
  //               const SizedBox(
  //                 height: 20.0,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  bool showLogin = true;
  bool showSignup = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Visibility(
            visible: showLogin,
            child: Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(top: 160.0),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Welcome Back",
                        style: Theme.of(context).textTheme.displaySmall),
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
                    Container(
                      margin: const EdgeInsets.only(left: 40.0),
                      child: Row(
                        children: [
                          const Text("Don't have account?"),
                          TextButton(
                            // style: TextButton.styleFrom(
                            //   textStyle: const TextStyle(fontSize: 20),
                            // ),
                            onPressed: displaySignUp,
                            child: const Text('Create a new account'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: showSignup,
            child: Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    PrimaryButton(
                        text: "atay", iconData: Icons.login, onPressed: login),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 70.0),
                      child: Row(
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            // style: TextButton.styleFrom(
                            //   textStyle: const TextStyle(fontSize: 20),
                            // ),
                            
                            onPressed: displayLogin,
                            child: const Text('Login'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  void displayLogin() {
    setState(() {
      showLogin = true;
      showSignup = false;
    });
  }

  void displaySignUp() {
    setState(() {
      showLogin = false;
      showSignup = true;
    });
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
