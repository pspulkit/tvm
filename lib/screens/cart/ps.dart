import 'package:app1/screens/homescreen/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Product_screen extends StatefulWidget {
  final ProductModel productModel;

  const Product_screen({Key? key, required this.productModel}) : super(key: key);

  @override
  State<Product_screen> createState() => _Product_screenState();
}

class _Product_screenState extends State<Product_screen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.purple.shade100,),
      body: SafeArea(
        child:
        SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      height: size.height * 0.5,
                      width: size.width * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.purple.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(widget.productModel.image[0])
                  )
                ],
              )
            ],
          ),

        ),
      ),
    );
    // return Container(
    //   child: Text(widget.productModel.name)
    // );
  }
}
