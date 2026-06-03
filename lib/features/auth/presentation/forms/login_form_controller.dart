import 'package:flutter/material.dart';

class LoginFormController {
  LoginFormController();

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
