import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/messaging_page.dart';
import '../pages/profile_page.dart';
import '../pages/search_page.dart';

// Navigation Page routes
List<Widget> navigationItems = [
  const HomePage(),
  const SearchPage(),
  const MessagingPage(),
  const ProfilePage(),
];

// For snackbar messages
void showSnackbar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        msg,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
