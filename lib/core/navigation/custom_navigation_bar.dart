import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  late PageController controller;

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      label: "Home",
    ),
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.cart),
      label: "Cart",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.local_restaurant_outlined),
      label: "Orders",
    ),
    const BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.person),
      label: "Profile",
    ),
  ];

  int currentIndex = 0;

  @override
  void initState() {
    controller = PageController(initialPage: currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: BottomNavigationBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          items: items,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          selectedIconTheme: const IconThemeData(
            color: AppColors.kWhiteColor,
            size: 35,
          ),
          selectedItemColor: AppColors.kWhiteColor,
          selectedLabelStyle: const TextStyle(
            color: AppColors.kWhiteColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          unselectedIconTheme: const IconThemeData(
            color: AppColors.kGreyColor,
            size: 25,
          ),
          unselectedLabelStyle: const TextStyle(
            color: AppColors.kGreyColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          unselectedItemColor: Colors.transparent,

          onTap: (index) {
            setState(() {
              currentIndex = index;
              controller.jumpToPage(index);
            });
          },
        ),
      ),

      body: PageView(controller: controller),
    );
  }
}
