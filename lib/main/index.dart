// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:pokemon_api/main/homepage.dart';
import 'components/custom_text_form_field.dart';
import 'components/password_field.dart';
import 'components/primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:pokemon_api/main/dashboard_argument.dart';

class Index extends StatefulWidget {
  static const String routeName = "login";
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  final loginEmailTextController = TextEditingController();
  final loginPasswordTextController = TextEditingController();
  final signUpEmailTextController = TextEditingController();
  final signUpPasswordTextController = TextEditingController();
  final signUpRepeatPasswordTextController = TextEditingController();
  bool obscureText = true;
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
              margin: const EdgeInsets.only(top: 130.0),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Welcome Back!",
                        style: Theme.of(context).textTheme.displaySmall),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      "Please Sign in to continue.",
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomTextFormField(
                        labelText: "Email Address",
                        hintText: "Enter a valid email",
                        iconData: Icons.email,
                        textInputType: TextInputType.emailAddress,
                        controller: loginEmailTextController),
                    const SizedBox(
                      height: 20.0,
                    ),
                    PasswordField(
                        labelText: "Password",
                        hintText: "Enter your password",
                        obscureText: obscureText,
                        onTap: setPasswordVisibility,
                        controller: loginPasswordTextController),
                    const SizedBox(
                      height: 20.0,
                    ),
                    PrimaryButton(
                        text: "Login",
                        iconData: Icons.login,
                        onPressed: loginWithEmail),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text("Or"),
                    SignInButton(
                      Buttons.Google,
                      onPressed: () {
                        loginWithGoogle();
                      },
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
              margin: const EdgeInsets.only(top: 160.0),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Create Account",
                        style: Theme.of(context).textTheme.displaySmall),
                    const SizedBox(
                      height: 20.0,
                    ),
                    CustomTextFormField(
                        labelText: "Email Address",
                        hintText: "Enter a valid email",
                        iconData: Icons.email,
                        textInputType: TextInputType.emailAddress,
                        controller: signUpEmailTextController),
                    const SizedBox(
                      height: 20.0,
                    ),
                    PasswordField(
                      labelText: "Password",
                      hintText: "Enter your password",
                      obscureText: obscureText,
                      onTap: setPasswordVisibility,
                      controller: signUpPasswordTextController,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    PasswordField(
                      labelText: "Repeat Password",
                      hintText: "Re-enter your password",
                      obscureText: obscureText,
                      onTap: setPasswordVisibility,
                      controller: signUpRepeatPasswordTextController,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    PrimaryButton(
                        text: "Confirm",
                        iconData: Icons.login,
                        onPressed: register),
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
                    ),
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

  void redirectHomepage(displayName, email) async {
    if (Navigator.canPop(context)) {
      Navigator.pop(context); //Ensures that context is empty when logging in
    }
    Navigator.pushReplacementNamed(context, Homepage.routeName,
        arguments: ScreenArguments(displayName, email));
  }

  void loginWithEmail() async {
    if (loginPasswordTextController.text.isNotEmpty &&
        loginEmailTextController.text.isNotEmpty) {
      try {
        final userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: loginEmailTextController.text,
                password: loginPasswordTextController.text);
        print(userCredential);
        // print(userCredential.user?.providerData[0].displayName);
        // print(userCredential.user?.email);
        final displayName = userCredential.user?.providerData[0].displayName;
        final email = userCredential.user?.email;
        redirectHomepage(displayName, email);
      } catch (e) {
        _showMyDialog('Failed to sign in', 'Invalid email or password.');
      }
    } else {
      _showMyDialog('Empty Field', 'All fields should have a value.');
    }
  }

  void loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print(userCredential);
      final displayName = userCredential.user?.providerData[0].displayName;
      final email = userCredential.user?.email;
      redirectHomepage(displayName, email);
    } catch (e) {
      print(e);
    }
  }

  void register() async {
    if (signUpPasswordTextController.text.isNotEmpty &&
        signUpEmailTextController.text.isNotEmpty &&
        signUpRepeatPasswordTextController.text.isNotEmpty) {
      try {
        if (signUpPasswordTextController.text ==
            signUpRepeatPasswordTextController.text) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: signUpEmailTextController.text,
              password: signUpPasswordTextController.text);
          User? currentUser = FirebaseAuth.instance.currentUser;
          final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
          final GoogleSignInAuthentication? googleAuth =
              await googleUser?.authentication;
          final googleCredential = GoogleAuthProvider.credential(
              accessToken: googleAuth?.accessToken,
              idToken: googleAuth?.idToken);
          print(currentUser);
          print(currentUser?.emailVerified);
          print(googleCredential);
          if (currentUser != null && !currentUser.emailVerified) {
            print("hehe");
            final credential =
                await currentUser.linkWithCredential(googleCredential);
            print(credential);
            print(currentUser.emailVerified);
            _showMyDialog('Account creation successful',
                'The account has been successfully been created.');
            FirebaseAuth.instance
                .signOut()
                .then((value) => GoogleSignIn().signOut());
          }

          // print(userCredential);
          // print(currentUser);
        } else {
          _showMyDialog('Password Mismatch', 'Please enter the same password.');
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          _showMyDialog('Weak Password',
              'The password provided is too weak please input up to 6 characters.');
        } else if (e.code == 'email-already-in-use') {
          _showMyDialog(
              'Duplicate email', 'The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    } else {
      _showMyDialog('Empty Field', 'All fields should have a value.');
    }
  }

  void setPasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  Future<void> _showMyDialog(title, message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
