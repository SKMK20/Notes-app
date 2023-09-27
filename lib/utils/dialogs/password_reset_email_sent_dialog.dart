import 'package:flutstar/extensions/list/build/loc.dart';
import 'package:flutstar/utils/dialogs/generic_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: context.loc.password_reset,
    content: context.loc.password_reset_dialog_prompt,
    optionsBuilder: () => {
      context.loc.okay: null,
    },
  );
}
