import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KnowMoreContainerWidget extends StatelessWidget {
  const KnowMoreContainerWidget(
      {super.key,
      required this.name,
      required this.sciName,
      required this.benefits,
      required this.origin,
      required this.inIndia,
      required this.bgColor});
 final String name;
  final String sciName;
  final String benefits;
  final String origin;
  final String inIndia;
  final Color bgColor;


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          height: height * 0.4,
          width: width,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 35,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: (){
                         Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 35,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      name,
                      style: GoogleFonts.itim(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 60,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 4),
                              blurRadius: 4,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "($sciName)",
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          )),
      SizedBox(
        height: height * 0.05,
      ),
      Container(
          height: height * 0.55,
          width: width,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 18, right: 18),
            child: Column(
              children: [
                Text(
                  benefits,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  origin,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "In India $inIndia",
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          )))
    ]));
  }
}
