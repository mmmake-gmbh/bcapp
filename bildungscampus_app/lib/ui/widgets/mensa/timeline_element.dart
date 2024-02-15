import 'package:bildungscampus_app/core/models/mensa/mensa_meal_plan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimelineElement extends StatefulWidget {
  const TimelineElement({
    super.key,
    required this.dayPlan,
    required this.selectedDayPlan,
    required this.textColor,
  });

  final Color textColor;
  final DayPlan dayPlan;
  final DayPlan? selectedDayPlan;

  @override
  State<TimelineElement> createState() => _TimelineElementState();
}

class _TimelineElementState extends State<TimelineElement>
    with TickerProviderStateMixin {
  final DecorationTween decorationTween = DecorationTween(
    begin: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      border: Border.all(
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.circular(210),
      // No shadow.
    ),
    end: BoxDecoration(
      color: const Color(0xFF2B78A7),
      border: Border.all(style: BorderStyle.none),
      borderRadius: BorderRadius.circular(210),
    ),
  );

  late final ColorTween _colorTween;
  late final Animation<Color?> _colorAnimation;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  @override
  void initState() {
    _colorTween = ColorTween(
      begin: widget.textColor,
      end: const Color(0xFFFFFFFF),
    );

    _colorAnimation = _colorTween.animate(_controller);

    if (widget.selectedDayPlan?.datum == widget.dayPlan.datum) {
      _controller.forward();
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant TimelineElement oldWidget) {
    if (oldWidget.selectedDayPlan?.datum != widget.selectedDayPlan?.datum) {
      if (widget.selectedDayPlan?.datum == widget.dayPlan.datum) {
        _controller.reset();
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBoxTransition(
      decoration: decorationTween.animate(_controller),
      child: Container(
        padding: const EdgeInsets.all(4),
        child: SizedBox(
          height: 22,
          width: 22,
          child: AnimatedBuilder(
            animation: _colorAnimation,
            builder: (context, _) => Text(
              DateFormat('d').format(widget.dayPlan.datum),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _colorAnimation.value,
                fontSize: 16,
                fontFamily: 'DIN OT',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
