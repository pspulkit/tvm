import 'package:app1/components/already_have_an_account_acheck.dart';
import 'package:app1/components/rounded_button.dart';
import 'package:app1/components/rounded_input_field.dart';
import 'package:app1/components/rounded_password_field.dart';
import 'package:app1/main.dart';
import 'package:app1/screens/login/components/background.dart';
import 'package:app1/screens/signup/signup_screen.dart';
import 'package:app1/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
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
            press: () async {
              try {
                UserCredential userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: email, password: password);
                if (userCredential.user != null) {
                  await FirebaseFirestore.instance
                      .collection("user")
                      .doc(userCredential.user!.uid)
                      .set(
                          {"name": "ss", "email": email, "password": password});
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const welcomescreen(title: "title")),
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
                    return SignUpScreen();
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
