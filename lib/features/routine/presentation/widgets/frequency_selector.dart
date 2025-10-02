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
          'تعداد روزهای تکرار در هفته',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade50,
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // دکمه کاهش
              _buildControlButton(
                icon: Icons.remove,
                onPressed: _selectedFrequency > 1
                    ? () => _updateFrequency(-1)
                    : null,
              ),

              // نمایش تعداد
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '$_selectedFrequency',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getDayText(_selectedFrequency),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // دکمه افزایش
              _buildControlButton(
                icon: Icons.add,
                onPressed: _selectedFrequency < 7
                    ? () => _updateFrequency(1)
                    : null,
              ),
            ],
          ),
        ),

        // نمایش بصری با نقاط
        const SizedBox(height: 12),
        _buildVisualIndicator(),

        // راهنما
        const SizedBox(height: 8),
        Text(
          'این روتین ${_selectedFrequency} بار در هفته تکرار خواهد شد',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
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
        color: onPressed != null ? Theme.of(context).primaryColor : Colors.grey[300],
        shape: BoxShape.circle,
        boxShadow: onPressed != null
            ? [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
        iconSize: 28,
      ),
    );
  }

  Widget _buildVisualIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(7, (index) {
        final isSelected = index < _selectedFrequency;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isSelected ? 28 : 20,
          height: isSelected ? 28 : 20,
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.grey[300],
            shape: BoxShape.circle,
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.4),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: isSelected
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                )
              : null,
        );
      }),
    );
  }

  String _getDayText(int count) {
    if (count == 1) return 'روز در هفته';
    if (count == 2) return 'روز در هفته';
    if (count == 7) return 'همه روزهای هفته';
    return 'روز در هفته';
  }
}
