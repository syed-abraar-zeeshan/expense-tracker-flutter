import 'package:flutter/material.dart';

class ResetPasswordFormController {
  ResetPasswordFormController();

  final formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
