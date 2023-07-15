import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutstar/utils/constants.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Column(
        children: [
          const Text(
              'we\'ve sent you an email verification. please verify by clicking the link'),
          const Text(
              'If you haven\' received a verification mail yet. press the button below'),
          ElevatedButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            },
            child: const Text('Send code'),
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!mounted) return;
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(signupRoute, (route) => false);
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
