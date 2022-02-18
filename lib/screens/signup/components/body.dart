import 'package:app1/components/already_have_an_account_acheck.dart';
import 'package:app1/components/rounded_button.dart';
import 'package:app1/components/rounded_input_field.dart';
import 'package:app1/components/rounded_password_field.dart';
import 'package:app1/screens/login/login_screen.dart';
import 'package:app1/screens/signup/components/background.dart';
import 'package:app1/screens/signup/components/or_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Body extends StatelessWidget {
  final Widget child;
  const Body({Key? key,
    required this.child}) : super(key: key);

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
            onChanged: (value){},
            ),
        RoundedPasswordField(
          onChanged: (value){},
        ),
        SizedBox(height: size.height * 0.01,),
        RoundedButton(
          text: "SIGNUP",
          press: (){},
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


