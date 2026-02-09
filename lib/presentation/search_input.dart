import 'package:flutter/material.dart';

/// Reusable search input used across screens.
class SearchInput extends StatelessWidget {
  const SearchInput({
    super.key,
    required this.onChanged,
    this.hintText = 'Search...',
  });

  final ValueChanged<String> onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: hintText,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
      onChanged: onChanged,
    );
  }
}
