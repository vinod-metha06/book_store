import 'package:book_store/nav/HomeView.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: <Widget>[
        HomeView(),
        Container(),
        HomeView(),
        Container(),
      ][_currentPageIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentPageIndex,
        destinations: const [
          NavigationDestination(icon: Icon(EvaIcons.compass), label: "Home"),
          NavigationDestination(
              icon: Icon(Icons.notifications_active), label: "Notifications"),
          NavigationDestination(icon: Icon(EvaIcons.heart), label: "Like"),
          NavigationDestination(icon: Icon(EvaIcons.person), label: "account"),
        ],
        onDestinationSelected: (value) {
          setState(() {
            _currentPageIndex = value;
          });
        },
      ),
    );
  }
}
