import 'package:flutter/material.dart';
import 'package:notes_app/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetEmailSenTDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Password reset',
    content: 'We have send you a password reset email, please check your email',
    optionsBuilder: () => {'OK': null},
  );
}
