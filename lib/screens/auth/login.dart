import 'package:flutter/material.dart';
import 'package:fruti_pedia/screens/auth/signup.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fruti_pedia/widget/textfield_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextStyle style = GoogleFonts.righteous(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 20,
      color: Color.fromRGBO(63, 86, 25, 1),
    ),
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isSinging = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _logIn() async {
    setState(() {
      _isSinging = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    try {
       await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        //;
      }
      if(mounted){
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.code),
          backgroundColor: const Color.fromARGB(255, 184, 111, 106),
        ),
      );
      }

      _emailController.clear();
      _passwordController.clear();
    }
    setState(() {
      _isSinging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/login.png',
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: height * 0.53,
                width: width,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(174, 206, 109, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Form(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 23, left: 25, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Login", style: style.copyWith(fontSize: 36)),
                      const SizedBox(
                        height: 4,
                      ),
                      Text("Email", style: style),
                      TextFieldWidget(
                        isPassword: false,
                        controller: _emailController,
                        bgColor: const Color.fromRGBO(234, 245, 202, 1),
                        text: "Enter your Email",
                        textColor: const Color.fromRGBO(220, 239, 171, 1),
                      ),
                      const SizedBox(
                        height: 33,
                      ),
                      Text(
                        "Password",
                        style: style,
                      ),
                      TextFieldWidget(
                        controller: _passwordController,
                        isPassword: true,
                        bgColor: const Color.fromRGBO(234, 245, 202, 1),
                        text: "Enter your password",
                        textColor: const Color.fromRGBO(220, 239, 171, 1),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(234, 245, 202, 1),
                          ),
                          onPressed: _logIn,
                          child: _isSinging
                              ? const CircularProgressIndicator(
                                  color: Color.fromRGBO(63, 86, 25, 1),
                                )
                              : Text("Login", style: style),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don’t have an account?",
                              style: style.copyWith(
                                fontSize: 18,
                                color: const Color.fromRGBO(0, 0, 0, 1),
                              )),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SignupScreen(),
                                ),
                              );
                            },
                            child: Text("Sign up",
                                style: style.copyWith(
                                  fontSize: 18,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
