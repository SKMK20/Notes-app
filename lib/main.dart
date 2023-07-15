import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutstar/pages/navigation_page.dart';
import 'package:flutstar/pages/signup_page.dart';
import 'package:flutstar/pages/verifyemail_page.dart';
import 'package:flutstar/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'pages/login_page.dart';

void main() async {
  // To use firebase in our app this is must with platform options.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                if (user.emailVerified) {
                  return const NavigationPage();
                } else {
                  return const VerifyEmailPage();
                }
              } else {
                return const LoginPage();
              }
              case ConnectionState.active:
              return const NavigationPage();
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
      routes: {
        loginRoute: (context) => const LoginPage(),
        signupRoute: (context) => const SignUpPage(),
        navigationRoute: (context) => const NavigationPage(),
        verifyEmailRoute:(context) => const VerifyEmailPage(),
      },
    ),
  );
}
