import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:quick_cab/widgets/button.dart';
import 'package:quick_cab/widgets/widgets.dart';

import '../configs/configs.dart';

class Setting {
  String name;
  IconData icon;

  Setting({required this.name, required this.icon});
}

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF5F8FF),
      appBar: AppBar(
        elevation: 0,
        foregroundColor: fontPrimary,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        centerTitle: true,
        title: Row(
          children: [
            const SizedBox(
              width: 44,
              height: 44,
            ),
            const Spacer(),
            Text(
              'Payment',
              style: TextStyle(
                color: fontPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: lightGrey2),
              ),
              child: const Icon(
                EvaIcons.bellOutline,
              ),
            )
          ],
        ),
      ),
    );
  }
}
