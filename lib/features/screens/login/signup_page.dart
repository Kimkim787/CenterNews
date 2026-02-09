import 'package:centernews/core/configurations/routes.dart';
import 'package:centernews/features/components/app_primary_button.dart';
import 'package:centernews/features/components/app_text_field.dart';
import 'package:centernews/features/screens/login/interface.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends GetView<IAuthController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create account')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CenterNews Sign Up',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: controller.firstNameController,
                        label: 'First name',
                        icon: Icons.badge_outlined,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppTextField(
                        controller: controller.lastNameController,
                        label: 'Last name',
                        icon: Icons.badge_outlined,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
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
                    label: 'Create account',
                    loadingLabel: 'Creating...',
                    icon: Icons.check_circle_outline,
                    isLoading: controller.isLoading.value,
                    onPressed: _submit,
                  ),
                ),
                TextButton(
                  onPressed: () => Get.offAllNamed(AppRoutes.login),
                  child: const Text('Back to Sign in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final success = await controller.signUp();
    if (success) {
      Get.snackbar('Account created', 'You can now sign in.');
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
