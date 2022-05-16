import 'package:flutter/material.dart';

class DialogNotification extends StatelessWidget {
  static const double iconSize = 64.0;

  final String title;
  final String content;
  final IconData? icon;
  final Color? iconColor;

  const DialogNotification(
      {required this.title,
      required this.content,
      this.icon,
      this.iconColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon != null
              ? Icon(
                  icon,
                  color: iconColor ?? Colors.grey,
                  size: iconSize,
                )
              : const SizedBox(),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(fontSize: 16))
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(), child: const Text('Ok'))
      ],
    );
  }
}

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return DialogNotification(
        title: 'Success',
        content: message,
        icon: Icons.check_box,
        iconColor: Colors.green);
  }
}

class ExceptionDialog extends StatelessWidget {
  const ExceptionDialog({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return DialogNotification(
        title: 'Exception',
        content: message,
        icon: Icons.error,
        iconColor: Colors.red);
  }
}
