import 'package:flutter/material.dart';

class WorkoutCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const WorkoutCard({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF3C3C3C),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(description, style: const TextStyle(color: Colors.grey)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.orange),
        onTap: onTap,
      ),
    );
  }
}
