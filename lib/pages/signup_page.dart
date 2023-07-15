import 'package:flutstar/services/auth/auth_exceptions.dart';
import 'package:flutstar/services/auth/auth_service.dart';
import 'package:flutstar/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _username;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _username = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _username.dispose();
    super.dispose();
  }

  final _signUpformKey = GlobalKey<FormState>();
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple.shade100,
                Colors.deepPurple.shade100,
                Colors.deepPurple.shade200,
                Colors.deepPurple.shade300,
                Colors.deepPurple.shade400,
                Colors.deepPurple.shade500,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              const Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SafeArea(
                        child: Text(
                          'Look\nall the stars,\nover the world.',
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Container(height: 50),
                        const Text(
                          'Flutstar',
                          style:
                              TextStyle(fontSize: 40, fontFamily: 'Pacifico'),
                        ),
                        Container(height: 20),
                        Form(
                          key: _signUpformKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _username,
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  prefixIcon: Icon(CupertinoIcons.person_fill),
                                  label: Text('Username'),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(30),
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-z_1234567890]"))
                                ],
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Username";
                                  }
                                  return null;
                                },
                              ),
                              Container(height: 15),
                              TextFormField(
                                controller: _email,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  prefixIcon: Icon(CupertinoIcons.mail_solid),
                                  label: Text('Email'),
                                ),
                                autocorrect: false,
                                enableSuggestions: false,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  bool emailValid = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_'{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value!);
                                  if (value.isEmpty) {
                                    return "Enter email";
                                  } else if (!emailValid) {
                                    return "Enter valid email";
                                  }
                                  return null;
                                },
                              ),
                              Container(height: 15),
                              TextFormField(
                                controller: _password,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  prefixIcon:
                                      const Icon(CupertinoIcons.lock_fill),
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          passToggle = !passToggle;
                                        });
                                      },
                                      child: Icon(
                                        passToggle
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      )),
                                  label: const Text('Password'),
                                ),
                                autocorrect: false,
                                enableSuggestions: false,
                                obscureText: passToggle,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter password";
                                  } else if (value.length < 6) {
                                    return "Password should be at least 6 characters";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (_signUpformKey.currentState!.validate()) {
                              final email = _email.text;
                              final password = _password.text;
                              try {
                                await AuthService.firebase().createUser(
                                  email: email,
                                  password: password,
                                );
                                AuthService.firebase().sendEmailVerification();
                                if (!mounted) return;
                                Navigator.of(context)
                                    .pushNamed(verifyEmailRoute);
                              } on EmailAlreadyInUseAuthException {
                                await showErrorDialog(
                                    context, 'Email is already in use');
                              } on InvalidEmailAuthException {
                                await showErrorDialog(context, 'Invalid email');
                              } on WeakPasswordAuthException {
                                await showErrorDialog(
                                    context, 'Password is too weak');
                              } on OperationNotAllowedAuthException {
                                await showErrorDialog(
                                    context, 'Some thing went wrong');
                              } on GenericAuthException {
                                await showErrorDialog(
                                    context, 'Failed to signup');
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black87,
                              elevation: 2,
                              padding:
                                  const EdgeInsets.fromLTRB(100, 10, 100, 10)),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Container(height: 10),
                        const Divider(thickness: 1),
                        Container(height: 10),
                        const Text(
                          'Already have an account?',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Container(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                loginRoute, (route) => false);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple.shade200,
                              elevation: 2,
                              padding:
                                  const EdgeInsets.fromLTRB(100, 10, 100, 10)),
                          child: const Text(
                            'Log in',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
