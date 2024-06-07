import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {required this.controller,
      required this.bgColor,
      required this.text,
      required this.textColor,
      required this.isPassword,
      super.key});

  final Color bgColor;
  final String text;
  final Color textColor;
  final TextEditingController? controller;
  final bool isPassword;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: widget.bgColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color.fromRGBO(0, 0, 0, 0.25),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword,
          textAlignVertical: TextAlignVertical.center,
          style: const TextStyle(decoration: TextDecoration.none),
          decoration: InputDecoration(
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            label: Text(
              widget.text,
              style: GoogleFonts.righteous(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: widget.textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
