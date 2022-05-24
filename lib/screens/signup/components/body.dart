import 'package:app1/components/already_have_an_account_acheck.dart';
import 'package:app1/components/rounded_button.dart';
import 'package:app1/components/rounded_input_field.dart';
import 'package:app1/components/rounded_password_field.dart';
import 'package:app1/screens/login/login_screen.dart';
import 'package:app1/screens/signup/components/background.dart';
import 'package:app1/screens/signup/components/or_divider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flash/flash.dart';
class Body extends StatefulWidget {
  final Widget child;
  const Body({Key? key,
    required this.child}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //SizedBox(height: size.height * 0.06,),
        Text("SIGN UP",
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.purple,),
        ),
        //SizedBox(height: size.height * 0.02,),
        SvgPicture.asset("assets/icons/signup.svg",
          height: size.height * 0.3,
        ),
        SizedBox(height: size.height * 0.03,),
        RoundedInputField(
            hintText: "Your Email",
            onChanged: (value){
              email = value;
            },
            ),
        RoundedPasswordField(
          onChanged: (value){
            password = value;
          },
        ),
        SizedBox(height: size.height * 0.01,),
        RoundedButton(
          text: "SIGNUP",
          press: () async {
            await Firebase.initializeApp();
            try {
              UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
              );
              if (userCredential.user != null){
                await FirebaseFirestore.instance
                    .collection("user")
                    .doc(userCredential.user!.uid)
                    .set(
                    {"email": email, "password": password});
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const LoginScreen()),
                        (_) => false);
              }
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                print('The account already exists for that email.');
              }
            } catch (e) {
              context.showToast(e);
            }
          },
        ),
        SizedBox(height: size.height * 0.01,),
        AlreadyHaveAnAccountCheck(
          login: false,
            press: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context){
                  return LoginScreen();
                  },
              ),
            );
            },
        ),
        //OrDivider(),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [Container(
        //     padding: EdgeInsets.all(5),
        //     decoration: BoxDecoration(
        //       border: Border.all(
        //         width: 0.5 ,
        //         color: Colors.deepPurple,
        //       ),
        //       shape: BoxShape.circle,
        //       ),
        //     child: SvgPicture.asset("assets/icons/facebook.svg", height: 20,width: 20,),
        //   ),
        //   ],
        //
        // )
        ],
   ), );
  }
}


