import 'package:bubble_navigation_bar/src/navigation_item.dart';
import 'package:flutter/material.dart';

class BubbleNavigationBar extends StatefulWidget {
  /// Current index of navigation
  final int currentIndex;

  /// Must be specified [BubbleNavItem] at least two
  final List<BubbleNavItem> items;

  /// Watch the navigation changes
  final void Function(int index) onIndexChanged;

  /// The padding of the whole navigation bar
  /// default is 24x8
  final EdgeInsetsGeometry? padding;

  /// To hide or show the selected label
  /// default is [true]
  final bool showSelectedLabel;

  /// Override the navigation colors
  final Color? backgroundColor, selectedItemColor, unselectedItemColor;

  /// Customize the iconSize
  /// default [24]
  final double? iconSize;

  /// Customize the label style
  final TextStyle? labelStyle;

  const BubbleNavigationBar(
      {super.key,
      required this.currentIndex,
      required this.items,
      required this.onIndexChanged,
      this.padding,
      this.showSelectedLabel = true,
      this.backgroundColor,
      this.selectedItemColor,
      this.unselectedItemColor,
      this.iconSize,
      this.labelStyle})
      : assert(items.length >= 2);

  @override
  State<BubbleNavigationBar> createState() => _BubbleNavigationBarState();
}

class _BubbleNavigationBarState extends State<BubbleNavigationBar> {
  int _currentIndex = 0;

  @override
  void initState() {
    _currentIndex = widget.currentIndex;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BubbleNavigationBar oldWidget) {
    if (oldWidget.currentIndex != widget.currentIndex) {
      _currentIndex = widget.currentIndex;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> navItems = [];

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: widget.items[_currentIndex].label,
      ),
      textDirection: TextDirection.ltr, // Specify text direction
    )..layout();

    double iconSize = widget.iconSize ?? 24.0;
    TextStyle labelStyle = widget.labelStyle ?? const TextStyle();

    double selectedItemWidth = textPainter.size.width + 4 + 28 + 24;
    double normalItemWidth = 64;
    double marginLeft = 0;
    EdgeInsetsGeometry padding =
        widget.padding ?? const EdgeInsets.symmetric(horizontal: 24);

    double totalWidth =
        MediaQuery.of(context).size.width - (padding.horizontal);
    double totalItemWidth =
        selectedItemWidth + ((widget.items.length - 1) * normalItemWidth);

    double space = (totalWidth - totalItemWidth) / (widget.items.length - 1);

    for (int index = 0; index < widget.items.length; index++) {
      var item = widget.items[index];
      bool selected = (_currentIndex == index);

      Color itemColor = widget.selectedItemColor ??
          item.color ??
          Theme.of(context).canvasColor;

      if (!selected) {
        itemColor = widget.unselectedItemColor ?? itemColor;
      }

      var itemPadding = _currentIndex == index
          ? const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            )
          : const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 8,
            );

      double itemWidth =
          _currentIndex == index ? selectedItemWidth : normalItemWidth;

      navItems.add(AnimatedPositioned(
        top: 0,
        bottom: 0,
        left: marginLeft + (padding.horizontal / 2),
        duration: const Duration(milliseconds: 400),
        child: Stack(
          children: [
            Align(
              child: Opacity(
                opacity: _currentIndex == index ? 0 : 1,
                child: Material(
                  color: Colors.transparent,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: IconButton(
                      onPressed: () => widget.onIndexChanged(index),
                      constraints: BoxConstraints.tightFor(
                        width: normalItemWidth,
                      ),
                      icon: item.icon,
                      iconSize: iconSize,
                      color: itemColor,
                      tooltip: item.label,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              child: Opacity(
                opacity: _currentIndex == index ? 1 : 0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 360),
                  decoration: BoxDecoration(
                    color:
                        _currentIndex == index ? itemColor.withAlpha(40) : null,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  padding: itemPadding,
                  child: Theme(
                    data: ThemeData(
                      iconTheme:
                          IconThemeData(color: itemColor, size: iconSize),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        item.icon,
                        if (selected && widget.showSelectedLabel)
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              item.label,
                              style: labelStyle.copyWith(
                                color: itemColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ));

      if (index == widget.items.length - 1) {
        marginLeft += itemWidth;
      } else {
        marginLeft += itemWidth + space;
      }
    }

    return Material(
      child: Container(
        height:
            64 + (widget.padding == null ? 0 : widget.padding!.vertical * 2),
        color: widget.backgroundColor ?? Theme.of(context).primaryColor,
        child: Stack(
          children: [
            ...navItems,
          ],
        ),
      ),
    );
  }
}
