import 'package:flutter/material.dart';
import 'package:lumo/l10n/l10n.dart';

@visibleForTesting
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
  final ValueSetter<int> onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home),
          label: l10n.bottomNavBarHome,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.check_circle_outline),
          activeIcon: const Icon(Icons.check_circle),
          label: l10n.bottomNavBarHabits,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.chat_bubble_outline),
          activeIcon: const Icon(Icons.chat_bubble),
          label: l10n.bottomNavBarAIChat,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          activeIcon: const Icon(Icons.person),
          label: l10n.bottomNavBarProfile,
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
