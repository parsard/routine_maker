// lib/features/routine/presentation/widgets/color_selector.dart
import 'package:flutter/material.dart';

class ColorSelector extends StatefulWidget {
  final Function(Color) onColorSelected;

  const ColorSelector({super.key, required this.onColorSelected});

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  final List<Color> _colors = [
    Colors.blue, Colors.green, Colors.red, Colors.orange,
    Colors.purple, Colors.teal, Colors.pink, Colors.amber,
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'انتخاب رنگ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 50,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_colors.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    widget.onColorSelected(_colors[index]);
                  },
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: _selectedIndex == index
                        ? Theme.of(context).primaryColor.withOpacity(0.7)
                        : Colors.transparent,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: _colors[index],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
