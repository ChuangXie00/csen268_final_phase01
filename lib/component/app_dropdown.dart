import 'package:flutter/material.dart';

class AppDropdown extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? selected;
  final ValueChanged<String?> onChanged;

  const AppDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: selected,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      ),
    );
  }
}
