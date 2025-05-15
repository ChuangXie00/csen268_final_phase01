import 'package:flutter/material.dart';

class SelectableTagButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const SelectableTagButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final pink = Colors.pinkAccent.shade100;
    final lightPurple = const Color(0xFFD6C8F3); // 淡紫色

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: selected ? lightPurple : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? lightPurple : pink,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selected)
                const Padding(
                  padding: EdgeInsets.only(right: 6),
                  child: Icon(Icons.check, size: 16, color: Colors.black),
                ),
              Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
