// lib/features/routine/presentation/widgets/routine_list_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class RoutineListItem extends StatefulWidget {
  final String title;
  final Color? color;
  final int targetRepetitions;
  final int completedRepetitions;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const RoutineListItem({
    super.key,
    required this.title,
    this.color,
    required this.targetRepetitions,
    required this.completedRepetitions,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  State<RoutineListItem> createState() => _RoutineListItemState();
}

class _RoutineListItemState extends State<RoutineListItem>
    with SingleTickerProviderStateMixin {
  List<bool> doneStatus = List.filled(7, false);
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _setupProgressAnimation();
  }

  void _setupProgressAnimation() {
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    final progressPercentage = widget.targetRepetitions > 0
        ? (widget.completedRepetitions / widget.targetRepetitions).clamp(0.0, 1.0)
        : 0.0;

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: progressPercentage,
    ).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: Curves.easeOutCubic,
      ),
    );

    // شروع انیمیشن با تاخیر کوتاه
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _progressController.forward();
      }
    });
  }

  @override
  void didUpdateWidget(RoutineListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    // اگر مقادیر تغییر کرد، انیمیشن رو دوباره اجرا کن
    if (oldWidget.completedRepetitions != widget.completedRepetitions ||
        oldWidget.targetRepetitions != widget.targetRepetitions) {
      _progressController.reset();
      _setupProgressAnimation();
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  Color _getProgressColor(double progress) {
    if (progress >= 1.0) {
      return Colors.green;
    } else if (progress >= 0.7) {
      return Colors.lightGreen;
    } else if (progress >= 0.4) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              // ردیف اول: عنوان و آیکون‌های روزها
              Row(
                children: [
                  // نقطه رنگی کنار عنوان
                  if (widget.color != null)
                    Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: widget.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Row(
                    children: List.generate(7, (index) {
                      return SizedBox(
                        width: dayColumnWidth,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              doneStatus[index] = !doneStatus[index];
                            });
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Icon(
                              doneStatus[index]
                                  ? Icons.check_circle
                                  : Icons.cancel_outlined,
                              color: doneStatus[index]
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),

              // Progress Bar با انیمیشن
              const SizedBox(height: 12),
              AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  final currentProgress = _progressAnimation.value;
                  final progressColor = _getProgressColor(currentProgress);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // متن پیشرفت
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'پیشرفت هفتگی',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            '${widget.completedRepetitions} از ${widget.targetRepetitions}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      // Progress Bar
                      Stack(
                        children: [
                          // پس‌زمینه
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          // پیشرفت با انیمیشن
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 8,
                            width: MediaQuery.of(context).size.width *
                                currentProgress,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  progressColor,
                                  progressColor.withOpacity(0.7),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: progressColor.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // درصد پیشرفت
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 1200),
                          curve: Curves.easeOutCubic,
                          tween: Tween(
                            begin: 0,
                            end: currentProgress * 100,
                          ),
                          builder: (context, value, child) {
                            return Text(
                              '${value.toStringAsFixed(0)}%',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: progressColor,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
