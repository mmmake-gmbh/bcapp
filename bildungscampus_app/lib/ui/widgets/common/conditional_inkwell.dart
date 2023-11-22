import 'package:flutter/material.dart';

class ConditionalInkWell extends StatelessWidget {
  final bool condition;
  final Widget child;
  final Function()? onTap;

  const ConditionalInkWell({
    super.key,
    required this.condition,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return condition
        ? InkWell(
            onTap: onTap,
            child: child,
          )
        : child;
  }
}
