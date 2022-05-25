import 'package:app1/components/already_have_an_account_acheck.dart';
import 'package:app1/components/rounded_button.dart';
import 'package:app1/components/rounded_input_field.dart';
import 'package:app1/components/rounded_password_field.dart';
import 'package:app1/screens/login/components/login_background.dart';
import 'package:app1/screens/signup/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../homescreen/home_screen.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoginBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "LOGIN",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.deepPurple,
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          SvgPicture.asset(
            "assets/icons/login.svg",
            height: size.height * 0.25,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          RoundedInputField(
            hintText: "your Email",
            onChanged: (value) {
              email = value;
            },
          ),
          RoundedPasswordField(
            onChanged: (value) {
              password = value;
            },
          ),
          //SizedBox(height: size.height * 0.02,),
          RoundedButton(
            text: "LOGIN",
            // press: (){
            //   Navigator.pushAndRemoveUntil(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (_) => const HomeScreen()),
            //                 (_) => false);
            // },
            press: () async {
              await Firebase.initializeApp();
              try {
                UserCredential userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: email, password: password);
                if (userCredential.user != null) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (_) => false);
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  print('No user found for that email.');
                } else if (e.code == 'wrong-password') {
                  print('Wrong password provided for that user.');
                }
              }
            },
          ),
          AlreadyHaveAnAccountCheck(
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
      ),
    );
  }
}
