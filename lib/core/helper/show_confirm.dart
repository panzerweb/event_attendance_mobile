import 'package:flutter/material.dart';

Future<void> showConfirmDialog({
  required BuildContext context,
  required Future<void> Function() onConfirm,
  String title = "Confirm",
  String message = "Are you sure?",
  String confirmText = "Delete",
}) async {
  return showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              await onConfirm();
              Navigator.of(dialogContext).pop();
            },
            child: Text(confirmText, style: const TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}
