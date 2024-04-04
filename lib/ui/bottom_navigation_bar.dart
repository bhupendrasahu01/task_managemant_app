import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:task_managemant_app/controllers/bottom_navigation_controller.dart';
import 'package:task_managemant_app/ui/theme.dart';

import 'Views/dashboard_page.dart';
import 'add_task_bar.dart';
import 'home_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final _controller = PersistentTabController(initialIndex: 0);

  BottomNavController bottomNavController = Get.put(BottomNavController());

  List<Widget> _buildScreen() {
    return [
      MyDashboard(),
      HomePage(),
      AddTaskPage(),
      Center(child: Text("Page 4",style: headingStyle,)),
      Center(child: Text("Settings Page",style: headingStyle))
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.home_filled,
            color: greenClr,
          ),
          inactiveIcon: Icon(
            Icons.home_filled,
            color: Colors.grey.shade500,
          )),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.insert_chart_outlined_rounded, color: greenClr),
          inactiveIcon: Icon(
            Icons.insert_chart_outlined_rounded,
            color: Colors.grey.shade500,
          )),
      PersistentBottomNavBarItem(
          activeColorPrimary: greenClr,
          activeColorSecondary: Colors.red,
          icon: Icon(Icons.add, color: greenClr),
          inactiveIcon: Icon(
            Icons.add,
            color: Colors.grey.shade100,
          )),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.calendar_month_outlined, color: greenClr),
          inactiveIcon: Icon(
            Icons.calendar_month_outlined,
            color: Colors.grey.shade500,
          )),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.settings, color: greenClr),
          inactiveIcon: Icon(
            Icons.settings,
            color: Colors.grey.shade500,
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreen(),
      items: _navBarsItems(),
      backgroundColor: Colors.white,
      decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(1),
          colorBehindNavBar: greenClr),
      navBarStyle: NavBarStyle.style15,
    );
  }
}
