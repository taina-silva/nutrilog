import 'package:flutter/material.dart';
import 'package:nutrilog/app/core/utils/constants.dart';
import 'package:nutrilog/app/core/utils/custom_colors.dart';

class MainBottomNavBar extends StatelessWidget {
  final void Function(int) onTap;
  final int currentIndex;

  const MainBottomNavBar({
    Key? key,
    required this.onTap,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Layout.bottomNavBarSize + MediaQuery.of(context).padding.bottom + 8,
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: CColors.neutral0,
        boxShadow: [Layout.boxShadow],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _CommonBottomNavBarIcon(
            onTap: () => onTap(0),
            icon: Icons.home,
            title: 'Início',
            selected: currentIndex == 0,
          ),
          _CommonBottomNavBarIcon(
            onTap: () => onTap(1),
            icon: Icons.trending_up,
            title: 'Gráficos',
            selected: currentIndex == 1,
          ),
        ],
      ),
    );
  }
}

class _CommonBottomNavBarIcon extends StatelessWidget {
  final bool selected;
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _CommonBottomNavBarIcon({
    Key? key,
    required this.selected,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: selected ? CColors.primaryActivity : CColors.neutral400, size: 35),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(color: selected ? CColors.primaryActivity : CColors.neutral400),
          )
        ],
      ),
    );
  }
}
