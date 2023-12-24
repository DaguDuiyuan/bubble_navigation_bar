import 'package:flutter/widgets.dart';

class BubbleNavItem {
  /// The icon for the navigation item
  final Widget icon;

  /// The label for the navigation item
  final String label;

  /// Customize the color of the navigation item
  final Color? color;

  const BubbleNavItem({
    required this.icon,
    required this.label,
    this.color,
  });
}
