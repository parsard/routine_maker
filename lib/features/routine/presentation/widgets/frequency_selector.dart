// lib/features/routine/presentation/widgets/frequency_selector.dart
import 'package:flutter/material.dart';

class FrequencySelector extends StatefulWidget {
  final Function(int) onFrequencyChanged;
  final int initialFrequency;

  const FrequencySelector({
    super.key,
    required this.onFrequencyChanged,
    this.initialFrequency = 1,
  });

  @override
  State<FrequencySelector> createState() => _FrequencySelectorState();
}

class _FrequencySelectorState extends State<FrequencySelector> {
  late int _selectedFrequency;

  @override
  void initState() {
    super.initState();
    _selectedFrequency = widget.initialFrequency;
  }

  void _updateFrequency(int delta) {
    setState(() {
      _selectedFrequency = (_selectedFrequency + delta).clamp(1, 7);
    });
    widget.onFrequencyChanged(_selectedFrequency);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'تعداد تکرار در هفته',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 16),
        
        // Counter Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Minus Button
            _buildControlButton(
              icon: Icons.remove,
              onPressed: _selectedFrequency > 1 ? () => _updateFrequency(-1) : null,
            ),

            // Display Number
            Column(
              children: [
                Text(
                  '$_selectedFrequency',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  _getDayText(_selectedFrequency),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),

            // Plus Button
            _buildControlButton(
              icon: Icons.add,
              onPressed: _selectedFrequency < 7 ? () => _updateFrequency(1) : null,
            ),
          ],
        ),

        // Visual Indicator
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(7, (index) {
            final isSelected = index < _selectedFrequency;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 24,
              height: 6,
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: onPressed != null
            ? Theme.of(context).primaryColor
            : Colors.grey[300],
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
        iconSize: 22,
      ),
    );
  }

  String _getDayText(int count) {
    if (count == 1) return 'روز در هفته';
    if (count == 7) return 'همه روزها';
    return 'روز در هفته';
  }
}