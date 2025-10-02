// lib/features/routine/presentation/widgets/routine_list_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:routine_maker/features/routine/domain/entities/routine_entity.dart';
import 'package:routine_maker/features/routine/presentation/notifiers/routine_item_notifier.dart';
import 'package:routine_maker/features/routine/presentation/providers/routine_providers.dart';

class RoutineListItem extends ConsumerStatefulWidget {
  final RoutineEntity routine;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const RoutineListItem({
    super.key,
    required this.routine,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  ConsumerState<RoutineListItem> createState() => _RoutineListItemState();
}

class _RoutineListItemState extends ConsumerState<RoutineListItem>
    with SingleTickerProviderStateMixin {
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

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.routine.progressPercentage,
    ).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: Curves.easeOutCubic,
      ),
    );

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _progressController.forward();
    });
  }

  @override
  void didUpdateWidget(RoutineListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.routine.completedRepetitionsThisWeek !=
            widget.routine.completedRepetitionsThisWeek ||
        oldWidget.routine.targetRepetitionsPerWeek !=
            widget.routine.targetRepetitionsPerWeek) {
      _progressController.reset();
      _setupProgressAnimation();
      
      // به‌روزرسانی notifier
      ref
          .read(routineItemNotifierProvider(widget.routine).notifier)
          .updateFromRoutine(widget.routine);
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemState = ref.watch(routineItemNotifierProvider(widget.routine));
    final notifier = ref.read(routineItemNotifierProvider(widget.routine).notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 8.0),
      child: Slidable(
        key: ValueKey(widget.routine.id),
        startActionPane: ActionPane(
          motion: const BehindMotion(),
          extentRatio: 1.0,
          children: _buildActionWidgets(),
        ),
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          extentRatio: 1.0,
          children: _buildActionWidgets(),
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
              _buildHeader(itemState, notifier),
              const SizedBox(height: 12),
              _buildProgressSection(notifier),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(RoutineItemState itemState, RoutineItemNotifier notifier) {
    return Row(
      children: [
        if (widget.routine.color != Colors.blue)
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              color: widget.routine.color,
              shape: BoxShape.circle,
            ),
          ),
        Expanded(
          child: Text(
            widget.routine.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        const SizedBox(width: 16.0),
        _buildDayIcons(itemState, notifier),
      ],
    );
  }

  Widget _buildDayIcons(RoutineItemState itemState, RoutineItemNotifier notifier) {
    return Row(
      children: List.generate(7, (index) {
        return SizedBox(
          width: 40.0,
          child: GestureDetector(
            onTap: itemState.isLoading ? null : () => notifier.toggleDay(index),
            child: Container(
              color: Colors.transparent,
              child: Icon(
                itemState.doneStatus[index]
                    ? Icons.check_circle
                    : Icons.cancel_outlined,
                color: itemState.doneStatus[index]
                    ? Colors.green
                    : Colors.grey,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildProgressSection(RoutineItemNotifier notifier) {
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
        final currentProgress = _progressAnimation.value;
        final progressColor = notifier.getProgressColor(currentProgress);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'پیشرفت هفتگی',
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
                Text(
                  '${widget.routine.completedRepetitionsThisWeek} از ${widget.routine.targetRepetitionsPerWeek}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            _buildProgressBar(currentProgress, progressColor),
            const SizedBox(height: 4),
            _buildProgressPercentage(currentProgress, progressColor),
          ],
        );
      },
    );
  }

  Widget _buildProgressBar(double progress, Color color) {
    return Stack(
      children: [
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 8,
          width: MediaQuery.of(context).size.width * progress,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withOpacity(0.7)],
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressPercentage(double progress, Color color) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 1200),
        curve: Curves.easeOutCubic,
        tween: Tween(begin: 0, end: progress * 100),
        builder: (context, value, child) {
          return Text(
            '${value.toStringAsFixed(0)}%',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildActionWidgets() {
    return [
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
}
