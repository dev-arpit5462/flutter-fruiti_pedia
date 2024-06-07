import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fruti_pedia/screens/know_more.dart';
import 'package:fruti_pedia/screens/select_img.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tflite/tflite.dart';

class OutputScreen extends StatefulWidget {
  const OutputScreen({super.key, required this.label, required this.selectedImage});

 final String label;
 final  File selectedImage;

  @override
  State<OutputScreen> createState() => _OutputScreenState();
}

class _OutputScreenState extends State<OutputScreen> {
  String grade = "Default";
  bool isGraded = false;
  // ignore: prefer_typing_uninitialized_variables
  late final model;

  @override
  void initState() {
    super.initState();
    loadModel(widget.label);
  }

  @override
  void dispose() {
    // Tflite.close();
    super.dispose();
  }

  String getModel(String label) {
    if (label == "Apple") {

      return "assets/models/freshness/apple.tflite";

    } else if (label == "Banana") {

      return "assets/models/freshness/banana.tflite";

    } else if (label == "Orange") {

      return "assets/models/freshness/orange.tflite";

    } else if (label.trim() == "Grape") {
      
        return "assets/models/freshness/grapes.tflite";
      

    } else {
      return "assets/models/freshness/strawberry.tflite";
    }
  }

  loadModel(String label) async {
    try {
      await Tflite.loadModel(
        model: getModel(label),
        labels: "assets/models/freshness/labels.txt",
      );
    } catch (e) {
        // 
    }
  }

  gradeing() async {
    var output = await Tflite.runModelOnImage(
        path: widget.selectedImage.path,
        numResults: 2,
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.5);

    if (output == null) {
      return;
    }
    setState(() {
      isGraded = true;
      grade = output[0]["label"];
    });
  }

  goBack() {
    if (mounted) {
    Tflite.close();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const SelectImageScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton(
        onPressed: () async {
          // Tflite.close();

          await gradeing();
        },
        child: Text(
          " Click To Grade...",
          style: GoogleFonts.itim(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 48,
                  color: Color.fromARGB(255, 157, 141, 170))),
        ));

    if (isGraded != false) {
      content = Text(
        grade,
        style: GoogleFonts.itim(
            textStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 48,
                color: Color.fromARGB(255, 157, 141, 170))),
      );
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: 
            const Text(
              "Result",
              style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 12, 13, 16),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromARGB(255, 42, 33, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.label,
              style: GoogleFonts.itim(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 48,
                      color: Color.fromARGB(255, 157, 141, 170))),
            ),
            Hero(
              tag: 'inImage',
              child: Image.file(
                widget.selectedImage,
                height: 300,
                width: 300,
              ),
            ),
            content,
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => KnowMoreScreen(label: widget.label,),
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 190, 190),
                shadowColor: const Color.fromARGB(255, 71, 70, 70),
              ),
              child: Text(
                " Know more",
                style: GoogleFonts.itim(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 48,
                      color: Colors.black),
                ),
              ),
              
            ),
          ],
        ),
      ),
    );
  }
}
