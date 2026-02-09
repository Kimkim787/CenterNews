import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:centernews/core/configurations/routes.dart';
import 'package:centernews/core/constants/user_constants.dart';
import 'package:centernews/core/error/error_messages.dart';
import 'package:centernews/core/models/seed_user.dart';
import 'package:centernews/features/screens/login/interface.dart';

class AuthController extends IAuthController {
  final SeedUser _adminUser = kDefaultAdminUser;
  final Rxn<SeedUser> _tempUser = Rxn<SeedUser>();

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
  SeedUser get user => _tempUser.value ?? _adminUser;

  SeedUser? _findUser(String username) {
    if (_tempUser.value != null && _tempUser.value!.username == username) {
      return _tempUser.value;
    }
    if (_adminUser.username == username) return _adminUser;
    return null;
  }

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
    await Future<void>.delayed(const Duration(milliseconds: 250));

    final matchedUser = _findUser(enteredUsername);
    final success =
        matchedUser != null && matchedUser.password == enteredPassword;

    if (success) {
      errorMessage.value = '';
      usernameController.clear();
      passwordController.clear();
    } else {
      errorMessage.value = ErrorMessages.invalidCredentials;
    }

    isLoading.value = false;
    return success;
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
    await Future<void>.delayed(const Duration(milliseconds: 250));

    _tempUser.value = SeedUser(
      username: username,
      password: password,
      firstName: first,
      lastName: last,
    );

    errorMessage.value = '';
    isLoading.value = false;

    firstNameController.clear();
    lastNameController.clear();
    usernameController.clear();
    passwordController.clear();

    return true;
  }

  @override
  void logout() {
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
