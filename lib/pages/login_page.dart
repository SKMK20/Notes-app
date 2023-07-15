import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutstar/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  final _loginformKey = GlobalKey<FormState>();
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
                  padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SafeArea(
                        child: Text(
                          'Welcome!',
                          style: TextStyle(
                              fontSize: 60, fontWeight: FontWeight.w500),
                        ),
                      ),
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
                          key: _loginformKey,
                          child: Column(
                            children: [
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
                                enableSuggestions: false,
                                autocorrect: false,
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
                                enableSuggestions: false,
                                autocorrect: false,
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
                            if (_loginformKey.currentState!.validate()) {
                              final email = _email.text;
                              final password = _password.text;
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );
                                if (!mounted) return;
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    navigationRoute, (route) => false);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  await showErrorDialog(
                                      context, 'User not found');
                                } else if (e.code == 'wrong-password') {
                                  await showErrorDialog(
                                      context, 'Wrong password');
                                } else if (e.code == 'invalid-email') {
                                  await showErrorDialog(
                                      context, 'Invalid email');
                                } else if (e.code == 'user-disabled') {
                                  await showErrorDialog(context,
                                      'This email is no longer in use');
                                } else {
                                  await showErrorDialog(
                                      context, 'Error: ${e.code}');
                                }
                              } catch (e) {
                                await showErrorDialog(context, e.toString());
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black87,
                              elevation: 2,
                              padding:
                                  const EdgeInsets.fromLTRB(100, 10, 100, 10)),
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Container(height: 10),
                        const Divider(thickness: 1),
                        Container(height: 10),
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Container(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                signupRoute, (route) => false);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple.shade200,
                              elevation: 2,
                              padding:
                                  const EdgeInsets.fromLTRB(100, 10, 100, 10)),
                          child: const Text(
                            'Create an account',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
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


