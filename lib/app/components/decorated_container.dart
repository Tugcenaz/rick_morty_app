import 'package:flutter/material.dart';

class DecoratedContainer extends StatelessWidget {
  Widget child;

  DecoratedContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topCenter,
          fit: BoxFit.fitWidth,
          image: AssetImage("assets/images/background_image.png"),
        ),
      ),
      child: child,
    );
  }
}

class DecoratedListContainer extends StatelessWidget {
  Widget child;

  DecoratedListContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(50),
        ),
      ),
      child: child,
    );
  }
}
