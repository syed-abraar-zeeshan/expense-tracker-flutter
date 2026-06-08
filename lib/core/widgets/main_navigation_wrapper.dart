import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:expense_flow/core/widgets/floating_bottom_nav_bar.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MainNavigationWrapper extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainNavigationWrapper({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: FloatingBottomNavBar(
        selectedIndex: navigationShell.currentIndex,
        onItemSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: const [
          FloatingBottomNavItem(
            activeIcon: Icons.home_rounded,
            inactiveIcon: Icons.home_outlined,
            label: 'Home',
          ),
          FloatingBottomNavItem(
            activeIcon: Icons.receipt_long_rounded,
            inactiveIcon: Icons.receipt_long_outlined,
            label: 'Expenses',
          ),
          FloatingBottomNavItem(
            activeIcon: Icons.pie_chart_rounded,
            inactiveIcon: Icons.pie_chart_outline_rounded,
            label: 'Categories',
          ),
          FloatingBottomNavItem(
            activeIcon: Icons.person_rounded,
            inactiveIcon: Icons.person_outline_rounded,
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add-expense'),
        elevation: 8,
        shape: const CircleBorder(),
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFF5D5FEF), Color(0xFF7000FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 32),
        ),
      ).animate().scale(delay: 400.ms, curve: Curves.easeOutBack),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
