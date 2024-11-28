import 'package:flutter/material.dart';

void showSnackBar(
    {required String message,
    required BuildContext context,
    required Color color}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Center(
        child: Text(
      message,
      style: TextStyle(color: Colors.white),
    )),
    backgroundColor: color,
  ));
}
