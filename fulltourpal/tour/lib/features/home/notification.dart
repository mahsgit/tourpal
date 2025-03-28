import 'package:flutter/material.dart';

class NotificationBadge extends StatelessWidget {
  final Widget child;
  final int count;
  final Color color;

  const NotificationBadge({
    Key? key,
    required this.child,
    required this.count,
    this.color = Colors.red,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        if (count > 0)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Center(
                child: Text(
                  count > 9 ? '9+' : count.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

