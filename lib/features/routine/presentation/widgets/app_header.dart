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
           Text(
                'روتین‌ساز',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              
          
           Row(
            children: [
              IconButton(
            icon:  Icon(Icons.add_circle_outline, size: 30),
            onPressed: onAddPressed,
            color: Theme.of(context).primaryColor,
          ),
            ],
          ),
        ],
      ),
    );
  }
}
