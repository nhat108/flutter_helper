import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;
  final ShimmerDirection shimmerDirection;
  const AppShimmer({
    Key? key,
    required this.child,
    this.baseColor,
    this.highlightColor,
    this.shimmerDirection = ShimmerDirection.ltr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: child,
      direction: shimmerDirection,
      baseColor: baseColor ?? Colors.grey[300]!,
      highlightColor: highlightColor ?? Colors.grey[100]!,
    );
  }
}
