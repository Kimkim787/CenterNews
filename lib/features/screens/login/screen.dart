import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:centernews/core/configurations/routes.dart';
import 'package:centernews/features/components/app_primary_button.dart';
import 'package:centernews/features/components/app_text_field.dart';
import 'package:centernews/features/screens/login/interface.dart';

class LoginScreen extends GetView<IAuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CenterNews Admin',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in with your admin account. Sign up is disabled.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey[700]),
                ),
                const SizedBox(height: 28),
                AppTextField(
                  controller: controller.usernameController,
                  label: 'Username',
                  icon: Icons.person_outline,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: controller.passwordController,
                  label: 'Password',
                  icon: Icons.lock_outline,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _submit(),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => controller.errorMessage.isEmpty
                      ? const SizedBox.shrink()
                      : Text(
                          controller.errorMessage.value,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => AppPrimaryButton(
                    label: 'Sign in',
                    loadingLabel: 'Signing in...',
                    icon: Icons.login,
                    isLoading: controller.isLoading.value,
                    onPressed: _submit,
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.signup),
                    child: const Text('Create account'),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Environment: ${const String.fromEnvironment('FLAVOR', defaultValue: 'prod').toUpperCase()}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final success = await controller.login();
    if (success) {
      Get.offAllNamed(AppRoutes.news);
    }
  }
}
