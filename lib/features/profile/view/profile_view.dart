import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hungry_app/core/utils/pref_helper.dart';
import 'package:hungry_app/features/profile/view/guest_profile.dart';
import 'package:hungry_app/features/profile/view/user_profile.dart';
import 'package:hungry_app/main.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool user = hasToken;
  @override
  void initState() {
    isUser();
    super.initState();
  }

  Future<void> isUser() async {
    user = await PrefHelper.isUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    log("Profile User: $user");
    return user ? const UserProfile() : const GuestProfile();
  }
}
