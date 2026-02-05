import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/features/cart/view/cart_view.dart';
import 'package:hungry_app/features/checkout/view/checkout_view.dart';
import 'package:hungry_app/features/home/view/home_view.dart';
import 'package:hungry_app/features/profile/view/profile_view.dart';

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

  List<Widget> pages = [
    const HomeView(),
    const CartView(),
    const CheckOutView(),
    const ProfileView(),
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
            size: 25,
          ),
          selectedItemColor: AppColors.kWhiteColor,
          selectedLabelStyle: const TextStyle(
            color: AppColors.kWhiteColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          unselectedIconTheme: const IconThemeData(
            color: AppColors.kGreyColor,
            size: 20,
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

      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: pages,
        ),
      ),
    );
  }
}
