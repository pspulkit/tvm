import 'package:app1/components/rounded_button.dart';
import 'package:app1/screens/login/login_screen.dart';
import 'package:app1/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'wellcome_background.dart';

class WellcomeBody extends StatelessWidget {
  const WellcomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WellcomeBackground(
      child: Column(
        children: [
          Text(
            "Hey!",
            style: TextStyle(
              color: Colors.deepPurple.shade200,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          SvgPicture.asset(
            'assets/icons/chat.svg',
            height: size.height * 0.45,
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          RoundedButton(
            text: "Login",
            color: Colors.deepPurpleAccent.shade100,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
          RoundedButton(
            text: "Sign Up",
            color: Colors.deepPurpleAccent.shade100,
            textColor: Colors.white,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
