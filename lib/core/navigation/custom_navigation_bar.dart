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
      icon: Icon(CupertinoIcons.clock),
      label: "History",
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.kPrimaryColor,
        items: items,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        fixedColor: AppColors.kPrimaryColor,
        selectedIconTheme: const IconThemeData(
          color: AppColors.kWhiteColor,
          size: 30,
        ),
        selectedLabelStyle: const TextStyle(
          color: AppColors.kWhiteColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        unselectedIconTheme: const IconThemeData(
          color: AppColors.kGreyColor,
          size: 20,
        ),
        unselectedLabelStyle: const TextStyle(
          color: AppColors.kGreyColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        onTap: (index) {
          setState(() {
            currentIndex = index;
            controller.jumpToPage(index);
          });
        },
      ),

      body: PageView.builder(
        itemCount: items.length,
        controller: controller,
        itemBuilder: (context, index) {
          return Container(color: Colors.red);
        },
      ),
    );
  }
}
