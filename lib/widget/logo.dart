import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget{
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
                        "FRUITY",
                        style: GoogleFonts.lalezar(
                          textStyle: const TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 255, 181, 52),
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Image.asset("assets/images/logo.png", height: 100, width: 150,),
                      Text(
                        "PEDIA",
                        style: GoogleFonts.lalezar(
                          textStyle: const TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 255, 181, 52),
                              fontWeight: FontWeight.w400),
                        ),
                      ),
    ],);
  }
}