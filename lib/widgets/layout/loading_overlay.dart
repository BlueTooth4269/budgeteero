import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const LoadingOverlay({super.key, required this.child, required this.isLoading});
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      child,
      if (isLoading) ...[
        const Opacity(
          opacity: 0.6,
          child: ModalBarrier(dismissible: false, color: Colors.black),
        ),
        const Center(
          child: CircularProgressIndicator(),
        )
      ]
    ]);
  }
}
