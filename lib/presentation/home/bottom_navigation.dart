import 'package:flutter/material.dart';
import 'package:shopywell/core/constants/colors_and_fonts.dart';
import 'package:shopywell/core/constants/main_variables.dart';
import 'package:shopywell/presentation/home/home.dart';
import 'package:shopywell/presentation/home/wishlist.dart';

class BottonNavigationWithScreen extends StatefulWidget {
  const BottonNavigationWithScreen({super.key});

  @override
  BottonNavigationWithScreenState createState() =>
      BottonNavigationWithScreenState();
}

class BottonNavigationWithScreenState
    extends State<BottonNavigationWithScreen> {
  int _selectedIndex = 0;
  bool cartActive = false;
  List screens = [HomeScreen(), Wishlist()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            child: screens[_selectedIndex],
          ),
        ),
        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          children: [
            BottomNavigationBar(
              backgroundColor: Pallete.kWhiteColor,
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              selectedItemColor: Pallete.kRedColor,
              unselectedItemColor: Pallete.kBlackColor,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border), label: 'Wishlist'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: 'Search'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings_outlined), label: 'Setting'),
              ],
            ),

            // Cart Button Positioned on Top of BottomNavigationBar
            Positioned(
              bottom: 20,
              left: Dimensions.screenWidth(context) / 2 - 30,
              child: GestureDetector(
                onTap: () {
                  cartActive = true;
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: cartActive ? Pallete.kRedColor : Pallete.kWhiteColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 5),
                    ],
                  ),
                  child: Icon(Icons.shopping_cart_outlined,
                      color: cartActive
                          ? Pallete.kWhiteColor
                          : Pallete.kBlackColor,
                      size: 25),
                ),
              ),
            ),
          ],
        ));
  }

  Widget buildNavItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              color: _selectedIndex == index
                  ? Pallete.kRedColor
                  : Pallete.kBlackColor),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: _selectedIndex == index
                  ? Pallete.kRedColor
                  : Pallete.kBlackColor,
            ),
          ),
        ],
      ),
    );
  }
}
