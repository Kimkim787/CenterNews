import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.loadingLabel,
    this.isLoading = false,
    this.width = double.infinity,
  });

  final String label;
  final String? loadingLabel;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isLoading;
  final double width;

  @override
  Widget build(BuildContext context) {
    final String buttonLabel = isLoading ? (loadingLabel ?? label) : label;

    return SizedBox(
      width: width,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(icon),
        label: Text(buttonLabel),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}


