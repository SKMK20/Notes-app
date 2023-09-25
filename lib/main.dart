import 'package:flutstar/helpers/loading/loading_page.dart';
import 'package:flutstar/pages/forgot_password_page.dart';
import 'package:flutstar/pages/login_page.dart';
import 'package:flutstar/pages/navigation_page.dart';
import 'package:flutstar/pages/notes/create_update_note_page.dart';
import 'package:flutstar/pages/signup_page.dart';
import 'package:flutstar/pages/verify_email_page.dart';
import 'package:flutstar/services/auth/bloc/auth_bloc.dart';
import 'package:flutstar/services/auth/bloc/auth_event.dart';
import 'package:flutstar/services/auth/bloc/auth_state.dart';
import 'package:flutstar/services/auth/firebase_auth_provider.dart';
import 'package:flutstar/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  // This widget is the root of your application.
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutStar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        // loginRoute: (context) => const LoginPage(),
        // signupRoute: (context) => const SignUpPage(),
        // navigationRoute: (context) => const NavigationPage(),
        // verifyEmailRoute: (context) => const VerifyEmailPage(),
        // notesRoute: (context) => const NotesPage(),
        createOrUpdateNoteRoute: (context) => const CreateUpdateNotePage(),
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please give us a moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NavigationPage();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailPage();
        } else if (state is AuthStateLoggedOut) {
          return const LoginPage();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordPage();
        } else if (state is AuthStateRegistering) {
          return const SignUpPage();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

// Counter app bloc practice
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late final TextEditingController _controller;

//   @override
//   void initState() {
//     _controller = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CounterBloc(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('testing bloc'),
//         ),
//         body: BlocConsumer<CounterBloc, CounterState>(
//           listener: (context, state) {
//             _controller.clear();
//           },
//           builder: (context, state) {
//             final invalidValue =
//                 (state is CounterStateInvalidNumber) ? state.invalidValue : "";

//             return Column(
//               children: [
//                 Text('Current value => ${state.value}'),
//                 Visibility(
//                   visible: state is CounterStateInvalidNumber,
//                   child: Text('Invalid input: $invalidValue'),
//                 ),
//                 TextField(
//                   controller: _controller,
//                   decoration:
//                       const InputDecoration(hintText: 'Enter a number here'),
//                   keyboardType: TextInputType.number,
//                 ),
//                 Row(
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         context
//                             .read<CounterBloc>()
//                             .add(DecrementEvent(_controller.text));
//                       },
//                       child: const Text('-'),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         context
//                             .read<CounterBloc>()
//                             .add(IncrementEvent(_controller.text));
//                       },
//                       child: const Text('+'),
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// @immutable
// abstract class CounterState {
//   final int value;
//   const CounterState(this.value);
// }

// class CounterStateValid extends CounterState {
//   const CounterStateValid(int value) : super(value);
// }

// class CounterStateInvalidNumber extends CounterState {
//   final String invalidValue;
//   const CounterStateInvalidNumber({
//     required this.invalidValue,
//     required int previousValue,
//   }) : super(previousValue);
// }

// @immutable
// abstract class CounterEvent {
//   final String value;
//   const CounterEvent(this.value);
// }

// class IncrementEvent extends CounterEvent {
//   const IncrementEvent(String value) : super(value);
// }

// class DecrementEvent extends CounterEvent {
//   const DecrementEvent(String value) : super(value);
// }

// class CounterBloc extends Bloc<CounterEvent, CounterState> {
//   CounterBloc() : super(const CounterStateValid(0)) {
//     on<IncrementEvent>((event, emit) {
//       final integer = int.tryParse(event.value);
//       if (integer == null) {
//         emit(
//           CounterStateInvalidNumber(
//             invalidValue: event.value,
//             previousValue: state.value,
//           ),
//         );
//       } else {
//         emit(CounterStateValid(state.value + integer));
//       }
//     });
//     on<DecrementEvent>((event, emit) {
//       final integer = int.tryParse(event.value);
//       if (integer == null) {
//         emit(
//           CounterStateInvalidNumber(
//             invalidValue: event.value,
//             previousValue: state.value,
//           ),
//         );
//       } else {
//         emit(CounterStateValid(state.value - integer));
//       }
//     });
//   }
// }
