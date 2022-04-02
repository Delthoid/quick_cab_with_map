import 'package:flutter/material.dart';
import 'package:quick_cab/configs/configs.dart';
import 'package:quick_cab/widgets/widgets.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: screenSidePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset('assets/intro.png'),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Book taxi, scooter or a bike within seconds',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: fontPrimary,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'The fastest app to book a taxi, scooter, or a bike online near by you ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w200,
                  color: fontGrey,
                ),
              ),
              const Spacer(),
              CustomButton(
                text: 'Give me a ride',
                wrap: false,
                onPressed: () {
                  Navigator.pushNamed(context, '/sign_up');
                },
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
