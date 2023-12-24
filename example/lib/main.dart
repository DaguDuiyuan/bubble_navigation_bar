import 'package:bubble_navigation_bar/bubble_navigation_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _pageController = PageController();
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _index = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Bubble Navigation Bar'),
      ),
      body: PageView(
        controller: _pageController,
        children: const [
          Center(
            child: Text(
              'Home',
            ),
          ),
          Center(
            child: Text(
              'Colors',
            ),
          ),
          Center(
            child: Text(
              'Favorite',
            ),
          ),
          Center(
            child: Text(
              'Profile',
            ),
          ),
          Center(
            child: Text(
              'Settings',
            ),
          ),
        ],
      ),
      bottomNavigationBar: BubbleNavigationBar(
        currentIndex: _index,
        // iconSize: 32,
        // padding: const EdgeInsets.symmetric(horizontal: 0),
        backgroundColor: Colors.black,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.orange.shade200,
        // showSelectedLevel: false,
        onIndexChanged: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 240),
            curve: Curves.decelerate,
          );
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
    );
  }
}
