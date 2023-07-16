import 'package:flutstar/services/auth/auth_service.dart';
import 'package:flutstar/utils/constants.dart';
import 'package:flutter/cupertino.dart';
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
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(signupRoute, (route) => false);
          },
          icon: const Icon(CupertinoIcons.back),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
              'we\'ve sent you an email verification,\nplease verify by clicking on the link'),
          const Text(
              'If you haven\' received a verification mail yet.\npress the button below'),
          ElevatedButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
            },
            child: const Text('Send link'),
          ),
          const Text(
              'After successful verification of email, now try to login'),
          ElevatedButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              if (!mounted) return;
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text('Log in'),
          ),
        ],
      ),
    );
  }
}
