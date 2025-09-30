// lib/features/routine/presentation/widgets/routine_list_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class RoutineListItem extends StatefulWidget {
  final String title;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const RoutineListItem({
    super.key,
    required this.title,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  State<RoutineListItem> createState() => _RoutineListItemState();
}

class _RoutineListItemState extends State<RoutineListItem> {
  List<bool> doneStatus = List.filled(7, false);

  @override
  Widget build(BuildContext context) {
    // Re-using the clean SlidableAction implementation from our previous conversation
    // استفاده مجدد از پیاده‌سازی تمیز قبلی برای اکشن‌های اسلاید
    List<Widget> createActionWidgets() {
      return [
        // Edit Action
        Expanded(
          child: InkWell(
            onTap: () {
              widget.onEdit();
              Slidable.of(context)?.close();
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit, color: Colors.white),
                  SizedBox(height: 4),
                  Text('ویرایش', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
        // Delete Action
        Expanded(
          child: InkWell(
            onTap: () {
              widget.onDelete();
              Slidable.of(context)?.close();
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete, color: Colors.white),
                  SizedBox(height: 4),
                  Text('حذف', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
      ];
    }
    
    // The same fixed width as in WeeklyCalendar for alignment
    // همان عرض ثابت استفاده شده در تقویم برای تراز کردن
    const double dayColumnWidth = 40.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 8.0),
      child: Slidable(
        key: ValueKey(widget.title),
        startActionPane: ActionPane(
          motion: const BehindMotion(),
          extentRatio: 1.0,
          children: createActionWidgets(),
        ),
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          extentRatio: 1.0,
          children: createActionWidgets(),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0), // This padding is crucial
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              // The title takes up the remaining flexible space
              // عنوان فضای باقی‌مانده و انعطاف‌پذیر را می‌گیرد
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.right, // Align text to the right
                ),
              ),
              // A fixed space between the title and the icons
              const SizedBox(width: 16.0),
              // Row for the 7 status icons
              Row(
                children: List.generate(7, (index) {
                  // Each icon is wrapped in a SizedBox with the same fixed width
                  // هر آیکون در یک SizedBox با همان عرض ثابت قرار می‌گیرد
                  return SizedBox(
                    width: dayColumnWidth,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          doneStatus[index] = !doneStatus[index];
                        });
                      },
                      // Using a transparent container to make the whole area tappable
                      child: Container(
                        color: Colors.transparent, 
                        child: Icon(
                          doneStatus[index]
                              ? Icons.check_circle
                              : Icons.cancel_outlined,
                          color: doneStatus[index] ? Colors.green : Colors.grey,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
