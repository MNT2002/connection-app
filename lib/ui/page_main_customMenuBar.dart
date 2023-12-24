import 'package:connection/ui/AppConstant.dart';
import 'package:flutter/material.dart';

class PageMainMenuCustom extends StatefulWidget {
  const PageMainMenuCustom({super.key});

  @override
  State<PageMainMenuCustom> createState() => _PageMainMenuCustomState();
}

class _PageMainMenuCustomState extends State<PageMainMenuCustom> {
  int currentIndex = 0; // Track the current index for the selected item
  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BottomNavigation Menu"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppConstant.secondaryColor,
        type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home', backgroundColor: AppConstant.mainColor),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile', backgroundColor: AppConstant.thirdColor),
          BottomNavigationBarItem(icon: Icon(Icons.list_sharp), label: 'DS Lớp', backgroundColor: Colors.red),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'), // New item
        ],
      ),
      body: _buildBody(), // Display different body content based on the selected index
    );
  }

  Widget _buildBody() {
    // Return a different widget based on the selected index
    switch (currentIndex) {
      case 0:
        return const Center(child: Text("Hello From Home"));
      case 1:
        return const Center(child: Text("Profile Page"));
      case 2:
        return const Center(child: Text("DS Lớp Page"));
      case 3:
        return const Center(child: Text("Favorites Page")); // New page
      default:
        return Container();
    }
  }
}

