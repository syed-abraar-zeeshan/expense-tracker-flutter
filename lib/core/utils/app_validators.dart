import 'package:expense_flow/core/constants/app_strings.dart';

class AppValidators {
  AppValidators._();

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$',
  );

  static final RegExp _uppercaseRegex = RegExp(r'[A-Z]');
  static final RegExp _lowercaseRegex = RegExp(r'[a-z]');
  static final RegExp _numberRegex = RegExp(r'[0-9]');
  static final RegExp _specialCharacterRegex = RegExp(
    r'[!@#$%^&*(),.?":{}|<>]',
  );

  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.requiredField;
    }

    return null;
  }

  static String? email(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return AppStrings.emailRequired;
    }

    if (!_emailRegex.hasMatch(email)) {
      return AppStrings.invalidEmail;
    }

    return null;
  }

  static String? password(String? value) {
    final password = value ?? '';

    if (password.isEmpty) {
      return AppStrings.passwordRequired;
    }

    if (password.length < 8) {
      return AppStrings.passwordMinLength;
    }

    if (!_uppercaseRegex.hasMatch(password)) {
      return AppStrings.passwordUppercase;
    }

    if (!_lowercaseRegex.hasMatch(password)) {
      return AppStrings.passwordLowercase;
    }

    if (!_numberRegex.hasMatch(password)) {
      return AppStrings.passwordNumber;
    }

    if (!_specialCharacterRegex.hasMatch(password)) {
      return AppStrings.passwordSpecialCharacter;
    }

    return null;
  }

  static String? confirmPassword(String? value, String password) {
    final confirmPassword = value ?? '';

    if (confirmPassword.isEmpty) {
      return AppStrings.confirmPasswordRequired;
    }

    if (confirmPassword != password) {
      return AppStrings.passwordMismatch;
    }

    return null;
  }
}
