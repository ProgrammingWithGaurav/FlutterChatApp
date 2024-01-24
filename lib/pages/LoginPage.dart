import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/components/button.dart';
import 'package:chat_app/components/textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  // on Tap function to navigate
  final void Function() onTap;
  // Email, Password controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginPage({super.key, required this.onTap});

  // Login function
  void login(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailAndPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString())));
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
              Text("Welcome back to Chat !!!",
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
              const SizedBox(height: 20),
              MyButton(text: "Login", onTap: () => login(context)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                      onTap: onTap,
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary),
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
