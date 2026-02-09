import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:centernews/core/api/auth/auth_api.dart';
import 'package:centernews/core/configurations/routes.dart';
import 'package:centernews/core/constants/user_constants.dart';
import 'package:centernews/core/error/error_messages.dart';
import 'package:centernews/core/models/seed_user.dart';
import 'package:centernews/features/screens/login/interface.dart';

class AuthController extends IAuthController {
  final Rxn<SeedUser> _currentUser = Rxn<SeedUser>();

  @override
  final TextEditingController usernameController = TextEditingController();

  @override
  final TextEditingController passwordController = TextEditingController();

  @override
  final TextEditingController firstNameController = TextEditingController();

  @override
  final TextEditingController lastNameController = TextEditingController();

  @override
  final RxString errorMessage = ''.obs;

  @override
  final RxBool isLoading = false.obs;

  @override
  SeedUser get user => _currentUser.value ?? kDefaultAdminUser;

  /// Validates credentials; UI handles navigation on success.
  @override
  Future<bool> login() async {
    final enteredUsername = usernameController.text.trim();
    final enteredPassword = passwordController.text;

    if (enteredUsername.isEmpty || enteredPassword.isEmpty) {
      errorMessage.value = ErrorMessages.enterCredentials;
      return false;
    }

    isLoading.value = true;
    try {
      final matchedUser = await AuthApi.login(
        username: enteredUsername,
        password: enteredPassword,
      );

      if (matchedUser != null) {
        _currentUser.value = matchedUser;
        errorMessage.value = '';
        usernameController.clear();
        passwordController.clear();
        return true;
      }

      errorMessage.value = ErrorMessages.invalidCredentials;
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Future<bool> signUp() async {
    final first = firstNameController.text.trim();
    final last = lastNameController.text.trim();
    final username = usernameController.text.trim();
    final password = passwordController.text;

    if ([first, last, username, password].any((e) => e.isEmpty)) {
      errorMessage.value = ErrorMessages.fillAllFields;
      return false;
    }

    isLoading.value = true;
    try {
      final createdUser = await AuthApi.signUp(
        firstName: first,
        lastName: last,
        username: username,
        password: password,
      );

      _currentUser.value = createdUser;
      errorMessage.value = '';

      firstNameController.clear();
      lastNameController.clear();
      usernameController.clear();
      passwordController.clear();

      return true;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void logout() {
    _currentUser.value = null;
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.onClose();
  }
}
