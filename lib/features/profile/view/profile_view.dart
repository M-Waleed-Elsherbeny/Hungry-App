import 'package:flutter/material.dart';
import 'package:hungry_app/features/profile/view/guest_profile.dart';
import 'package:hungry_app/features/profile/view/user_profile.dart';
import 'package:hungry_app/main.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return token != null ? const UserProfile() : const GuestProfile();
  }
}
