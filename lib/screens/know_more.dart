import 'package:flutter/material.dart';
import 'package:fruti_pedia/data/data.dart';

import 'package:fruti_pedia/widget/know_more_container.dart';

class KnowMoreScreen extends StatefulWidget {
   const KnowMoreScreen({
    super.key,
    required this.label
  });
  final String label;

  @override
  State<KnowMoreScreen> createState() => _KnowMoreScreenState();
}

class _KnowMoreScreenState extends State<KnowMoreScreen> {
  var fruit;
  String name = "Data loading failed... Restart!!";
  String image = "assets/images/placeholder.png";
  String benefits = "Data loading failed... Restart!!";
  String origin = "Data loading failed... Restart!!";
  String inIndia = "Data loading failed... Restart!!";
  String sciName = "Data loading failed... Restart!!";
  Color bgColor = const Color.fromARGB(1, 162, 180, 201);
  Map<String, Color> bgColorMap = {
    "Apple": const Color(0XFFCCCD7B),
    "Banana": const Color.fromARGB(1, 162, 180, 201),
  };

  getData() {
    fruit = fruitData[widget.label];
    name = widget.label;
    image = fruit["image"];
    sciName = fruit["sciName"];
    benefits = fruit["benefits"];
    origin = fruit["origin"];
    inIndia = fruit["inIndia"];
    bgColor = fruit["bgColor"]!;
  }

  @override
  void initState() {
    setState(() {
      getData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          KnowMoreContainerWidget(
              name: name,
              sciName: sciName,
              benefits: benefits,
              origin: origin,
              inIndia: inIndia,
              bgColor: bgColor),
          Positioned(
            top: 150,

            // bottom: ,
            child: SizedBox(
                // height: double.infinity,
                // width: double.infinity,
                child: Image.asset(
              image,
              height: 250,
              width: 300,
              fit: BoxFit.fill,
            )),
          )
          // Center(
          //   child:
          // )
        ],
      ),
    );
  }
}
