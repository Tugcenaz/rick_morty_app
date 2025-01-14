import 'package:flutter/material.dart';

AppBar appBar({required String title, required Widget actions}) {
  return AppBar(
    title: Text(title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
    actions: [actions],
  );
}
