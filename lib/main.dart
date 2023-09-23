import 'package:flutstar/pages/login_page.dart';
import 'package:flutstar/pages/navigation_page.dart';
import 'package:flutstar/pages/notes/create_update_note_page.dart';
import 'package:flutstar/pages/notes/notes_page.dart';
import 'package:flutstar/pages/signup_page.dart';
import 'package:flutstar/pages/verifyemail_page.dart';
import 'package:flutstar/services/auth/auth_service.dart';
import 'package:flutstar/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  // To use firebase in our app this is must with platform options.
  WidgetsFlutterBinding.ensureInitialized();
  AuthService.firebase().initialize();

  // To avoid auto rotation in devices.
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // This widget is the root of your application.
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutStar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: ((context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              if (user != null) {
                if (user.isEmailVerified) {
                  return const NavigationPage();
                } else {
                  return const VerifyEmailPage();
                }
              } else {
                return const LoginPage();
              }
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        }),
      ),
      routes: {
        loginRoute: (context) => const LoginPage(),
        signupRoute: (context) => const SignUpPage(),
        navigationRoute: (context) => const NavigationPage(),
        verifyEmailRoute: (context) => const VerifyEmailPage(),
        notesRoute: (context) => const NotesPage(),
        createOrUpdateNoteRoute: (context) => const CreateUpdateNotePage(),
      },
    ),
  );
}
