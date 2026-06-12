import 'package:flutter/material.dart';

class ForgotPasswordFormController {
  ForgotPasswordFormController();

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  void dispose() {
    emailController.dispose();
  }
}
