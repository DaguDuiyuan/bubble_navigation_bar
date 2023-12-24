# BubbleNavigationBar

Easy to use Flutter bubble bottom navigation bar

## Preview

<img src="https://raw.githubusercontent.com/ygnCybernoob/bubble_navigation_bar/main/gif/preview1.gif" height="500em">
<img src="https://raw.githubusercontent.com/ygnCybernoob/bubble_navigation_bar/main/gif/preview2.gif" height="500em">
## Usage

To use this plugin, add bubble_navigation_bar as a dependency in your [pubspec.yaml](https://flutter.io/using-packages/) file.

## Additional information

BubbleNavigationBar is very easy to use, like BottomNavigationBar. BubbleNavItem is used for navigation items.

```dart
Scaffold(
    bottomNavigationBar: BubbleNavigationBar(
    currentIndex: _index,
    onIndexChanged: (index) {
        setState(() {
        _index = index;
        });
    },
    items: const [
        BubbleNavItem(
        icon: Icon(Icons.home),
        label: 'Home',
        ),
        BubbleNavItem(
        icon: Icon(Icons.color_lens),
        label: 'Colors',
        ),
        BubbleNavItem(
        icon: Icon(Icons.star),
        label: 'Favorite',
        ),
        BubbleNavItem(
        icon: Icon(Icons.person),
        label: 'Profile',
        ),
        BubbleNavItem(
        icon: Icon(Icons.settings),
        label: 'Settings',
        ),
    ],
    ),
)
```

```dart
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
```
