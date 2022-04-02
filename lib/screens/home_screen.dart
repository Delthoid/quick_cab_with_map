import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:quick_cab/configs/color.dart';
import 'package:quick_cab/screens/home.dart';
import 'package:quick_cab/screens/messages_screen.dart';
import 'package:quick_cab/screens/payments_screen.dart';
import 'package:quick_cab/screens/profile_screen.dart';
import 'package:quick_cab/widgets/button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var navBarIndex = 0;

  final PageController controller = PageController();

  BottomNavigationBarItem buildNavBaritem({
    required String label,
    required IconData icon,
    required int index,
  }) {
    var theme = Theme.of(context);
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: index == navBarIndex ? theme.primaryColor : lightGrey,
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 25,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          child: BottomNavyBar(
            selectedIndex: navBarIndex,
            showElevation: false, // use this to remove appBar's elevation
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            curve: Curves.ease,
            onItemSelected: (index) => setState(
              () {
                navBarIndex = index;
                controller.animateToPage(index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              },
            ),
            items: [
              BottomNavyBarItem(
                textAlign: TextAlign.center,
                icon: Icon(
                  navBarIndex == 0 ? EvaIcons.home : EvaIcons.homeOutline,
                ),
                title: const Text('Home'),
                activeColor: theme.primaryColor,
                inactiveColor: lightGrey,
              ),
              BottomNavyBarItem(
                textAlign: TextAlign.center,
                icon: Icon(
                  navBarIndex == 1
                      ? EvaIcons.creditCard
                      : EvaIcons.creditCardOutline,
                ),
                title: const Text('Payments'),
                activeColor: theme.primaryColor,
                inactiveColor: lightGrey,
              ),
              BottomNavyBarItem(
                textAlign: TextAlign.center,
                icon: Icon(
                  navBarIndex == 2
                      ? EvaIcons.messageCircle
                      : EvaIcons.messageCircleOutline,
                ),
                title: const Text('Messages'),
                activeColor: theme.primaryColor,
                inactiveColor: lightGrey,
              ),
              BottomNavyBarItem(
                textAlign: TextAlign.center,
                icon: Icon(
                  navBarIndex == 3 ? EvaIcons.person : EvaIcons.personOutline,
                ),
                title: const Text('Profile'),
                activeColor: theme.primaryColor,
                inactiveColor: lightGrey,
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: controller,
        onPageChanged: (index) {
          setState(() {
            navBarIndex = index;
          });
        },
        children: const [
          Home(),
          PaymentScreen(),
          MessagesScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
