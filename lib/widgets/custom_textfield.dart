import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:quick_cab/configs/color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.inputType,
    this.decorated,
    this.prefixIcon,
    this.formKey,
  }) : super(key: key);

  final String hintText;
  final TextInputType inputType;
  final bool? decorated;
  final IconData? prefixIcon;
  final GlobalKey<FormState>? formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        validator: (value) {
          if (formKey != null) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          }
        },
        decoration: decorated == null
            ? InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
              )
            : InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(27.5),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: lightGrey2,
                hintText: hintText,
                prefixIcon: Icon(prefixIcon ?? EvaIcons.search),
                labelStyle: const TextStyle(
                  fontSize: 16,
                ),
              ),
        keyboardType: inputType,
      ),
    );
  }
}
