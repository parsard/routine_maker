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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              ' رنگ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        const SizedBox(height: 8),
        
        LayoutBuilder(builder: (context, constraints) {
          
          final int columns = constraints.maxWidth >= 600 ? 6 : 5;
          const double spacing = 12.0;

          final double itemWidth = (constraints.maxWidth - (columns - 1) * spacing) / columns;
          final double innerRadius = (itemWidth * 0.35).clamp(14.0, 20.0);
          final double outerRadius = innerRadius + 4.0;

          return SizedBox(
            height: outerRadius * 2 * ((_colors.length / columns).ceil()) + spacing * ((_colors.length / columns).ceil() - 1),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: List.generate(_colors.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                        widget.onColorSelected(_colors[index]);
                      },
                      child: SizedBox(
                        width: itemWidth,
                        child: Center(
                          child: CircleAvatar(
                            radius: outerRadius,
                            backgroundColor: _selectedIndex == index
                                ? Theme.of(context).primaryColor.withOpacity(0.7)
                                : Colors.transparent,
                            child: CircleAvatar(
                              radius: innerRadius,
                              backgroundColor: _colors[index],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
