import 'package:flutter/material.dart';
import 'package:quick_cab/configs/color.dart';

class Handle extends StatelessWidget {
  const Handle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 63,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: lightGrey,
      ),
    );
  }
}
