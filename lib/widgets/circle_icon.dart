import 'package:flutter/material.dart';
import 'package:quick_cab/configs/configs.dart';

class CircleIcon extends StatelessWidget {
  const CircleIcon({
    Key? key,
    required this.iconData,
  }) : super(key: key);

  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: lightPurple,
      ),
      child: Icon(
        iconData,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
