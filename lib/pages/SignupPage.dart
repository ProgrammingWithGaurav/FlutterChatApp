import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/components/button.dart';
import 'package:chat_app/components/textfield.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  // on Tap function to navigate
  final void Function() onTap;
  // Email, Password controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  SignupPage({super.key, required this.onTap});

  // Login function
  void signup(BuildContext context) {
    final authService = AuthService();
    if (passwordController.text == confirmPasswordController.text) {
      try {
        authService.signUpWithEmailAndPassword(
            emailController.text, passwordController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(title: Text(e.toString())));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(title: Text("Password don't match!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 40),
              Text("Create an new Account!",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16)),
              const SizedBox(height: 20),
              MyTextField(
                hintText: "Email",
                controller: emailController,
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: "Password",
                controller: passwordController,
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: "Confirm Password",
                controller: confirmPasswordController,
              ),
              const SizedBox(height: 20),
              MyButton(text: "Signup", onTap: () => signup(context)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                      onTap: onTap,
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary),
                      ))
                ],
              ),
            ],
          ),
        ));
  }
}
