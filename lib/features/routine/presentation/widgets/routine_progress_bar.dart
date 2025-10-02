import 'package:flutter/material.dart';

class RoutineProgressBar extends StatelessWidget {
  final int completed; 
  final int target; 
  final Color color;

  const RoutineProgressBar({
    super.key,
    required this.completed,
    required this.target,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    final progress = target > 0 ? (completed / target).clamp(0.0, 1.0) : 0.0;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$completed از $target بار',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
