// lib/features/routine/presentation/widgets/app_header.dart
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final VoidCallback onAddPressed;

  const AppHeader({
    super.key,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // دکمه افزودن در سمت چپ (در RTL)
          IconButton(
            icon: const Icon(Icons.add_circle_outline, size: 30),
            onPressed: onAddPressed,
            color: Theme.of(context).primaryColor,
          ),
          // لوگو و نام برنامه در سمت راست (در RTL)
          const Row(
            children: [
              Text(
                'روتین‌ساز',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.checklist_rtl_rounded,
                color: Colors.deepPurple,
                size: 32,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
