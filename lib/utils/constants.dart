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

// Routes
const loginRoute = '/login/';
const signupRoute = '/signup/';
const navigationRoute = '/navigation/';
const verifyEmailRoute = '/verify-email/';
const notesRoute = '/notes/';
const newNoteRoute = '/notes/new-note/';


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

// Error dialog box
Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('An error occurred'),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Okay'),
          ),
        ],
      );
    },
  );
}
