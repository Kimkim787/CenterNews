import 'dart:async';

import 'package:centernews/core/constants/user_constants.dart';
import 'package:centernews/core/models/seed_user.dart';

/// Fake auth API that mimics network latency while using local seed data.
class AuthApi {
  const AuthApi._();

  static SeedUser? _tempUser;

  static SeedUser? _findUser(String username) {
    if (_tempUser != null && _tempUser!.username == username) {
      return _tempUser;
    }
    if (kDefaultAdminUser.username == username) {
      return kDefaultAdminUser;
    }
    return null;
  }

  static Future<SeedUser?> login({
    required String username,
    required String password,
    Duration latency = const Duration(milliseconds: 650),
  }) async {
    await Future.delayed(latency);
    final user = _findUser(username);
    if (user == null || user.password != password) {
      return null;
    }
    return user;
  }

  static Future<SeedUser> signUp({
    required String firstName,
    required String lastName,
    required String username,
    required String password,
    Duration latency = const Duration(milliseconds: 750),
  }) async {
    await Future.delayed(latency);
    _tempUser = SeedUser(
      username: username,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
    return _tempUser!;
  }

  static void clearTempUser() {
    _tempUser = null;
  }
}
