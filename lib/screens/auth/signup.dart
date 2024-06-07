import 'package:flutter/material.dart';
import 'package:fruti_pedia/screens/auth/login.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:fruti_pedia/widget/textfield_widget.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextStyle style = GoogleFonts.righteous(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 20,
      color: Color.fromRGBO(141, 3, 33, 1),
    ),
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isSingingUp = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cnfPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _cnfPasswordController.dispose();

    super.dispose();
  }

  void _signUp() async {
    setState(() {
      _isSingingUp = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;
    if (password == _cnfPasswordController.text) {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        if (mounted) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.code),
            backgroundColor: const Color.fromARGB(255, 184, 111, 106),
          ));
        }
      }
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Password mismatch "),
        backgroundColor: Color.fromARGB(255, 184, 111, 106),
      ));
    }
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _cnfPasswordController.clear();
    setState(() {
      _isSingingUp = false;
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
              'assets/images/signup.png',
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: height * 0.6,
                width: width,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(253, 253, 253, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                      child: Padding(
                    padding:
                        const EdgeInsets.only(top: 23, left: 25, right: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Sign Up", style: style.copyWith(fontSize: 36)),
                        const SizedBox(
                          height: 4,
                        ),
                        Text("Name", style: style),
                        TextFieldWidget(
                          controller: _nameController,
                          bgColor: const Color.fromRGBO(255, 240, 243, 1),
                          text: "Enter your Name",
                          textColor: const Color.fromRGBO(230, 201, 206, 1),
                          isPassword: false,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Text("Email", style: style),
                        TextFieldWidget(
                          controller: _emailController,
                          bgColor: const Color.fromRGBO(255, 240, 243, 1),
                          text: "Enter your Email",
                          textColor: const Color.fromRGBO(230, 201, 206, 1),
                          isPassword: false,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Text("Password", style: style),
                        TextFieldWidget(
                          controller: _passwordController,
                          bgColor: const Color.fromRGBO(255, 240, 243, 1),
                          text: "Enter a password",
                          textColor: const Color.fromRGBO(230, 201, 206, 1),
                          isPassword: true,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Text("Confirm Password", style: style),
                        TextFieldWidget(
                          controller: _cnfPasswordController,
                          bgColor: const Color.fromRGBO(255, 240, 243, 1),
                          text: "Re-Enter password",
                          textColor: const Color.fromRGBO(230, 201, 206, 1),
                          isPassword: true,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(255, 240, 243, 1),
                            ),
                            onPressed: _signUp,
                            child: _isSingingUp
                                ? const CircularProgressIndicator(
                                    color: Color.fromRGBO(141, 3, 33, 1),
                                  )
                                : Text(
                                    "Sign up",
                                    style: style,
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?",
                                style: style.copyWith(
                                  fontSize: 18,
                                  color: const Color.fromRGBO(0, 0, 0, 1),
                                )),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: Text("Login",
                                  style: style.copyWith(
                                    fontSize: 18,
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
