import 'package:diary/chart/barchart.dart';
import 'package:diary/info/infoscreen.dart';
import 'package:diary/pet/spinwheel/spinwheel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diary/calendar/calendar.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottonNavBar extends StatefulWidget {
  const BottonNavBar({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BottonNavBar();
  }
}

class _BottonNavBar extends State<BottonNavBar> {
  //const _BottonNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> buildScreens() {
      return [
        Chart(),
        Calendar(),
        const SpinWheel(),
        ProfileScreen(),
      ];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.bar_chart),
          title: ("統計"),
          activeColorPrimary: Color.fromARGB(255, 0, 0, 0),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(
            CupertinoIcons.calendar,
          ),
          title: ("日曆"),
          activeColorPrimary: Color.fromARGB(255, 0, 0, 0),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.shopping_bag_outlined),
          title: ("商店"),
          activeColorPrimary: Color.fromARGB(255, 0, 0, 0),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.perm_identity),
          title: ("個人資訊"),
          activeColorPrimary: Color.fromARGB(255, 0, 0, 0),
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    }

    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 1);
    Future<bool> onWillPop() async {
      if (controller.index != 1) {
        // 如果当前不是第二页
        controller.jumpToTab(1); // 切换到第二页
        return false; // 阻止默认的返回操作
      }
      return true; // 执行默认的返回操作
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: PersistentTabView(
        context,
        controller: controller,
        screens: buildScreens(),
        items: navBarsItems(),
        confineToSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style6, // Choose the nav bar style with this property.
      ),
    );
  }
}
