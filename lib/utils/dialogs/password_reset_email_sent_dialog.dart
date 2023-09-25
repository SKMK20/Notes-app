import 'package:flutstar/utils/dialogs/generic_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Password Reset',
    content: 'We have sent you a password reset link to your email. Please check your email.',
    optionsBuilder: () => {
      'Okay': null,
    },
  );
}
