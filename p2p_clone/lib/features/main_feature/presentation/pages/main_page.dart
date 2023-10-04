import 'package:flutter/material.dart';
import 'package:p2p_clone/features/main_feature/presentation/pages/add_car_page.dart';
import 'package:p2p_clone/features/main_feature/presentation/pages/rentals_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int navIndex = 0;
  List<Widget> pages = const [
    RentalsPage(),
    AddCarPage(),
    // TODO add a profile page to make the app work with finger print
    Center(
      child: Text('Profile Page'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('P2P Car Rental App Clone'),
      ),
      body: pages[navIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.car_rental),
            label: 'Rentals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Rental',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: navIndex,
        onTap: (index) {
          setState(() {
            navIndex = index;
          });
        },
        showUnselectedLabels: false,
      ),
    );
  }
}
