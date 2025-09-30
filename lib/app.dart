import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class App extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const App({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8, 
              activeColor: Colors.white, 
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Theme.of(context).primaryColor, 
              color: Colors.black, 
              tabs: const [
                GButton(
                  icon: Icons.bar_chart_outlined,
                  text: 'آمار',
                ),
                GButton(
                  icon: Icons.home_outlined,
                  text: 'خانه',
                ),
                GButton(
                  icon: Icons.note_alt_outlined,
                  text: 'یادداشت',
                ),
              ],
              selectedIndex: navigationShell.currentIndex,
              onTabChange: (index) {
                navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
