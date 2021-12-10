import 'package:flutter/material.dart';

class OverlayLoading extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const OverlayLoading({Key? key, required this.child, this.isLoading = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        if (isLoading)
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Container(
                color: Colors.black,
              ),
            ),
          ),
        if (isLoading)
          Positioned.fill(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(20),
                child: const CircularProgressIndicator(
                  backgroundColor: Colors.black,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
