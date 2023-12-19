import 'package:flutter/material.dart';

void showDialogs({
  required String title,
  required String body,
  required VoidCallback onPlayAgain,
  required VoidCallback onCancel,
  required BuildContext context,
}) {
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            TextButton(
              onPressed: onCancel,
              child: const Text('QUIT'),
            ),
            TextButton(
              onPressed: onPlayAgain,
              child: const Text('PLAY AGAIN'),
            ),
          ],
        );
      });
}

void showErrorSnack({
  required BuildContext context,
  required String errorMessage,
}) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(errorMessage)));
}
