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
    Colors.blue,
    Colors.lightBlue,
    Colors.indigo,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.teal,
    Colors.cyan,
    Colors.blueGrey,
    Colors.brown,
    Colors.grey,
    Colors.black,
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'رنگ',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 16),
        
        // Color Grid
        SizedBox(
          height: 180,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: _colors.length,
            itemBuilder: (context, index) {
              final isSelected = _selectedIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                  widget.onColorSelected(_colors[index]);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _colors[index],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? Colors.black
                          : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: _colors[index].withOpacity(0.4),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          color: _colors[index].computeLuminance() > 0.5
                              ? Colors.black
                              : Colors.white,
                          size: 16,
                        )
                      : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}