import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fruti_pedia/screens/output.dart';
import 'package:fruti_pedia/widget/image_input.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:tflite/tflite.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class SelectImageScreen extends StatefulWidget {
  const SelectImageScreen({super.key});

  @override
  State<SelectImageScreen> createState() => _SelectImageScreenState();
}

class _SelectImageScreenState extends State<SelectImageScreen> {
  File? _selectedImage;
  String label="Default";
  // double 

  @override
  void initState() {
    super.initState();
    // loadModel().then((value) {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }
  loadModel() async {
    try{
     await Tflite.loadModel(
      model: "assets/models/classification/classification.tflite",
      labels: "assets/models/classification/classi_label.txt",
    );
    }catch(e){
      //
    }
  }
    runModel(String path) async {
    var output = await Tflite.runModelOnImage(
      path:path,
      numResults: 5, 
      imageMean: 127.5,
      imageStd: 127.5,
      threshold: 0.6
      
    );

    if(output!=null){
      label = output[0]["label"];
      print(output);

    }
    
  }


  grade() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please Pick an Image to continue"),
          backgroundColor: Color.fromARGB(255, 184, 111, 106),
        ),
      );

      return;
    }
    await runModel(_selectedImage!.path);

    print(label);

  if(mounted){

     Tflite.close();
Navigator.of(context)
        .push(MaterialPageRoute(
          builder: (context) => OutputScreen(label: label,selectedImage: _selectedImage!,),
        ));
  }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 12, 13, 16),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut();
                ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Signed Out"),
          backgroundColor: Color.fromARGB(255, 20, 123, 51),
        ),
      );
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color.fromARGB(255, 42, 33, 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 40,
              ),
              Image.asset(
                "assets/images/logo2.png",
                height: 100,
                width: 175,
              ),
              ImageInput(
                onPickImage: (image) {
                  _selectedImage = image;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  Tflite.close();
                  await loadModel();
                  await grade();
                },
                child: const Text("GRADE"),
                style: const ButtonStyle(),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 2,
                indent: 60,
                endIndent: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(1, 251, 246, 238),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Ready to know about your fruit? Simply click the above Icon and click the image..",
                      style: GoogleFonts.reemKufiFun(
                          textStyle: const TextStyle(
                              fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
