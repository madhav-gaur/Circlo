import 'package:circlo/core/components/buttons.dart';
import 'package:circlo/core/components/circle_card.dart';
import 'package:circlo/core/themes/borders.dart';
import 'package:circlo/core/themes/colors.dart';
import 'package:circlo/core/themes/fonts.dart';
import 'package:circlo/core/themes/paddings.dart';
import 'package:circlo/features/auth/screens/profile.dart';
import 'package:circlo/features/circles/screens/circles.dart';
import 'package:circlo/features/circles/screens/home.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currIndex = 0;
  List<Widget> pages = [Home(), Circles(), Profile()];
  @override
  Widget build(BuildContext context) {
    double screenWidth =
        MediaQuery.of(context).size.width - 32;
    double itemWidth = screenWidth / 3;
    return Scaffold(
      appBar: AppBar(title: Text("Circlo")),
      body: Padding(
        padding: AppPadding.pagePadding,
        child: Stack(
          children: [
            pages[currIndex],

            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Container(
                height: 70,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: AppBorders.pill,
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.primary.withAlpha(50)),
                ),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      curve: Curves.easeInOut,
                      bottom: 5,
                      duration: Duration(milliseconds: 200),
                      left: (currIndex * itemWidth) + ((itemWidth - 100) / 2),
                      child: Container(
                        width: 100,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(20),
                          borderRadius: AppBorders.pill,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        bottomBarItem(
                          "Home",
                          Icons.home_outlined,
                          Icons.home,
                          0,
                        ),
                        bottomBarItem(
                          "Circles",
                          Icons.group_outlined,
                          Icons.group,
                          1,
                        ),
                        bottomBarItem(
                          "Profile",
                          Icons.person_2_outlined,
                          Icons.person_2,
                          2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomBarItem(String label, IconData icon, activeIcon, int index) {
    final bool isActive = currIndex == index;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          // splashColor: Colors.transparent,
          onTap: () {
            setState(() {
              currIndex = index;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isActive ? activeIcon : icon,
                color: isActive ? AppColors.primary : Colors.grey,
              ),
              Text(
                label,
                style: AppFonts.button.copyWith(
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  color: isActive ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
