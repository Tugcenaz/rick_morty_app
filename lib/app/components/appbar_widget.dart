import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  final bool isTransparentBackground;

  const AppbarWidget(
      {super.key, required this.title, this.isTransparentBackground = false});

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: isTransparentBackground ? Colors.transparent : null,
      title: Text(title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.settings))],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
