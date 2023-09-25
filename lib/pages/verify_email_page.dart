import 'package:flutstar/services/auth/bloc/auth_bloc.dart';
import 'package:flutstar/services/auth/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        title: const Text('Verify your email'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
              'we\'ve sent you an email verification,\nplease verify by clicking on the link'),
          const Text(
              'If you haven\' received a verification mail yet.\npress the button below'),
          ElevatedButton(
            onPressed: () {
              context
                  .read<AuthBloc>()
                  .add(const AuthEventSendEmailVerification());
            },
            child: const Text('Send link'),
          ),
          const Text(
              'After successful verification of email, now try to login'),
          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEventLogOut());
            },
            child: const Text('Log in'),
          ),
        ],
      ),
    );
  }
}
