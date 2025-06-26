import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _goToBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        
        backgroundColor: AppColors.whiteColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Cart',
            icon: Icon(Icons.add_shopping_cart),
          ),
          BottomNavigationBarItem(
            label: 'Purcharses',
            icon: Icon(Icons.shopping_bag_outlined),
          ),
          /* BottomNavigationBarItem(
            label: 'Favorite',
            icon: Icon(Icons.favorite),
          ), */
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.redColor,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _goToBranch(_selectedIndex);
        },
      ),
    );
  }
}
