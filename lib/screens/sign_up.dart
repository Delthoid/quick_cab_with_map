import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_cab/configs/configs.dart';
import 'package:quick_cab/widgets/custom_textfield.dart';
import 'package:quick_cab/widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String dropdownValue = 'One';
  Widget inputPhoneNumber() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: lightGrey,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: CountryCodePicker(
              onChanged: print,
              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
              initialSelection: 'IT',
              favorite: const ['+39', 'FR'],
              // optional. Shows only country name and flag
              showCountryOnly: false,
              // optional. Shows only country name and flag when popup is closed.
              showOnlyCountryWhenClosed: true,

              // optional. aligns the flag and the Text left
              alignLeft: true,
            ),
          ),
          const Divider(),
          Padding(
            padding:
                const EdgeInsets.only(left: 24, right: 24, bottom: 8, top: 8),
            child: CustomTextField(
              formKey: _formKey,
              hintText: 'Phone number',
              inputType: TextInputType.phone,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: screenSidePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Text(
                'Welcome to Quick Cab 🚕',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: smallSpacing,
              ),
              Text(
                'The fastest app to book a taxi, scooter, or a bike online near by you ',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w200,
                  color: fontGrey,
                ),
              ),
              SizedBox(
                height: smallSpacing,
              ),
              inputPhoneNumber(),
              const Spacer(),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'By clicking on “Continue” you are agreeing to to our ',
                  style: TextStyle(
                    color: fontGrey,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'terms of use ',
                      style: TextStyle(
                        color: theme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomButton(
                text: 'Continue',
                wrap: false,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          Future.delayed(Duration(seconds: 3)).then((value) =>
                              Navigator.pushNamedAndRemoveUntil(context,
                                  '/home', (Route<dynamic> route) => false));
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        });
                  }
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
