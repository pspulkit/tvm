



import 'package:app1/components/rounded_button.dart';
import 'package:app1/screens/homescreen/product_model.dart';
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
      appBar: AppBar(backgroundColor: Colors.purple.shade100,title: Text("Product Details"),),
      body: SafeArea(
        child:
        Column(
            children: [
              Expanded(
                flex: 9,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.network(widget.productModel.image[1],
                        height: size.height * 0.5,
                        alignment: Alignment.topCenter,
                      ),
                      SizedBox(width: size.width,height: 30,),
                      Container(
                          width: size.width,
                          padding: EdgeInsets.only(left:20),
                          child: Text(
                            widget.productModel.name,
                            style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                      ),
                      SizedBox(width: size.width,height: 30,),
                      Container(
                        width: size.width,
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
<<<<<<< HEAD
                           'Price : Rs ${widget.productModel.mrp}',
=======
                          'Rs ${widget.productModel.mrp}',
>>>>>>> origin/shopping-apk
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          )
                        ),
                      ),
<<<<<<< HEAD
                      SizedBox(width: size.width,height: 30,),
=======
>>>>>>> origin/shopping-apk
                      Container(
                        width: size.width,
                        height: size.height*0.5,
                        padding: EdgeInsets.only(left: 50),
                        child: Text(
<<<<<<< HEAD
                          "Groceries means any raw or processed food or bev- erage, or any ingredient thereof, intended for human con- sumption except alcoholic beverages, marijuana products, and tobacco. “Groceries” includes, but is not limited to, meat, poultry, fish, fruits, vegetables, grains, bread, milk, cheese and other dairy products, nonalcoholic beverages, kombucha with less than 0.5% alcohol by volume, con- diments, spices, cereals, seasonings, leavening agents, eggs, cocoa, teas, and coffees whether raw or processed.",
=======
                          widget.productModel.name,
>>>>>>> origin/shopping-apk
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                        ),
                      )
                    ],
                  )
                ),
              ),
              Expanded(
                flex: 1,
                child: RoundedButton(text: "Add to cart",press: ()
                  {}
                  ),
              ),
            ],
          ),
        ),

      );

  }
}

// SingleChildScrollView(
// child: Column(
// children: [
// Image.network(widget.productModel.image[1],
// height: size.height * 0.5,
// alignment: Alignment.topCenter,
// ),
// SizedBox(width: size.width,height: 30,),
// Container(
// width: size.width,
// padding: EdgeInsets.only(left: 50),
// child: Text(
// 'Rs. ${widget.productModel.mrp!}',
// style: TextStyle(
// color: Colors.purple,
// fontWeight: FontWeight.bold,
// fontSize: 30,
// ),
// )
// ),
// // Container(
// //   alignment: Alignment.center,
// //   height: size.height * 0.5,
// //   width: size.width * 0.5,
// //   decoration: BoxDecoration(
// //     color: Colors.purple.shade50,
// //     shape: BoxShape.circle,
// //   ),
// // )
// // Padding(
// //   padding: const EdgeInsets.only(left: 80,),
// //   child: Container(
// //     alignment: Alignment.center,
// //     height: size.height * 0.5,
// //     width: size.width * 0.5,
// //     decoration: BoxDecoration(
// //       color: Colors.purple.shade50,
// //       shape: BoxShape.circle,
// //     ),
// //     child: Image.network(widget.productModel.image[1]),
// //   ),
// //
// // ),
// // Container(
// //     alignment: Alignment.center,
// //     height: size.height * 0.5,
// //     width: size.width * 0.5,
// //     decoration: BoxDecoration(
// //       color: Colors.purple.shade50,
// //       shape: BoxShape.circle,
// //     ),
// // ),
// ],
// ),
//
// )