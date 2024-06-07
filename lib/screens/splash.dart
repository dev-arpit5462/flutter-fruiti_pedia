import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruti_pedia/screens/auth/login.dart';
import 'package:fruti_pedia/screens/select_img.dart';
import 'package:fruti_pedia/widget/logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => screen),
      );
    });
  }

  Widget screen = StreamBuilder(stream:FirebaseAuth.instance.authStateChanges() ,builder: (ctx, snapshot){
    
        if(snapshot.hasData){
          return  const SelectImageScreen();
        }

        return LoginScreen();
      },);

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromARGB(255, 250, 247, 238),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[ Center(
            child: Logo(),
          ),]
        ),
      ),
    );
  }
}
