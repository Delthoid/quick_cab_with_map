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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Setting> settings = [
    Setting(name: 'Profile info', icon: EvaIcons.personOutline),
    Setting(name: 'Cards', icon: EvaIcons.creditCard),
    Setting(name: 'Settings', icon: EvaIcons.settings2Outline),
    Setting(name: 'Activities', icon: EvaIcons.clockOutline),
  ];

  Widget promotionCard(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: theme.primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You won 300 points',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            const Text(
              'Thanks for riding with us! you won 300 point from your last ride',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            CustomButton.small(
              'Redeem now 🔥',
              () {},
              theme.primaryColor,
              Colors.white,
              true,
              12,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSettings() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  CircleIcon(iconData: settings.elementAt(index).icon),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    settings.elementAt(index).name,
                    style: TextStyle(
                      fontSize: 16,
                      color: fontPrimary,
                    ),
                  ),
                  const Spacer(),
                  const Icon(EvaIcons.chevronRight)
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(
          color: lightGrey2,
        ),
        itemCount: settings.length,
      ),
    );
  }

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
              'Profile',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: screenSidePadding,
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/avatar.png',
                  width: 120,
                  height: 120,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                'Delts ',
                style: TextStyle(
                  fontSize: 24,
                  color: fontPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              promotionCard(context),
              const SizedBox(
                height: 32,
              ),
              buildSettings(),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
