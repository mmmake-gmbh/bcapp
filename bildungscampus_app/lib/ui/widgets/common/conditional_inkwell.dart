import 'package:flutter/material.dart';

class ConditionalInkWell extends StatelessWidget {
  final bool condition;
  final Widget child;
  final Function()? onTap;

  const ConditionalInkWell({
    Key? key,
    required this.condition,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return condition
        ? InkWell(
            child: child,
            onTap: onTap,
          )
        : child;
  }
}
