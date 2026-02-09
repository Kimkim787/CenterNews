import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:centernews/core/models/seed_user.dart';

/// Contract for auth/login controllers.
abstract class IAuthController extends GetxController {
  TextEditingController get usernameController;
  TextEditingController get passwordController;
  TextEditingController get firstNameController;
  TextEditingController get lastNameController;
  RxString get errorMessage;
  RxBool get isLoading;

  SeedUser get user;

  Future<bool> login();
  Future<bool> signUp();
  void logout();
}


