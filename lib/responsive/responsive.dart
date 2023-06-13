import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget widget;
  const Responsive({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: widget,
      ),
    );
  }
}
