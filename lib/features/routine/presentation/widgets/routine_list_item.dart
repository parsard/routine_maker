// lib/features/routine/presentation/widgets/routine_list_item.dart
import 'package:flutter/material.dart';
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
  // لیستی از وضعیت تیک‌ها برای 7 روز هفته
  List<bool> doneStatus = List.filled(7, false);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(widget.title),
      // پنل اکشن‌ها (در RTL در سمت چپ ظاهر می‌شود)
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => widget.onDelete(),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'حذف',
            borderRadius: BorderRadius.circular(12),
          ),
          SlidableAction(
            onPressed: (context) => widget.onEdit(),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'ویرایش',
            borderRadius: BorderRadius.circular(12),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title, style: const TextStyle(fontSize: 16)),
            Row(
              children: List.generate(7, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      doneStatus[index] = !doneStatus[index];
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Icon(
                      doneStatus[index] ? Icons.check_circle : Icons.cancel_outlined,
                      color: doneStatus[index] ? Colors.green : Colors.grey,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
