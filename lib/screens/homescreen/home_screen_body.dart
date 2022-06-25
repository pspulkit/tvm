import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../cart/cart_screen.dart';
import 'category_model.dart';
import 'product_model.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  List<CategoryModel> itemList = List.empty(growable: true);
  List<ProductModel> productList = List.empty(growable: true);
  ScrollController controllerTypeDataList = ScrollController();

  @override
  void initState() {
    fetchAndSetList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: CustomScrollView(
          controller: controllerTypeDataList,
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width * 0.65,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.purple.shade50,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "search Item",
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.06,
                      width: size.width * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.purple.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset("assets/icons/Bell.svg"),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const CartScreen();
                        }));
                      },
                      child: Container(
                          height: size.height * 0.06,
                          width: size.width * 0.1,
                          decoration: BoxDecoration(
                            color: Colors.purple.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.shopping_cart,
                            size: 36,
                          )),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < itemList.length; i++)
                      InkWell(
                        onTap: () {
                          productList.clear();
                          fetchProduct(itemList[i].id);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 5, right: 5),
                          width: 150,
                          height: size.height * 0.2,
                          decoration: BoxDecoration(
                            color: Colors.purple.shade50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.network(itemList[i].image),
                        ),
                      )
                  ],
                ),
              ),
            ])),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              delegate: SliverChildListDelegate(productList
                  .map(((e) => InkWell(
                        onTap: () {
                          /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      Product_screen(productModel: e))); */
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(15),
                          width: size.width * 0.9,
                          height: size.height * 0.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 10,
                                right: 10,
                                top: -20,
                                bottom: 5,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  alignment: FractionalOffset.topCenter,
                                  width: size.width * 0.3,
                                  height: size.height * 0.3,
                                  child: Image.network(e.image[0]),
                                ),
                              ),
                              /*
                              * image
                              * contaner=>black
                              * column
                              * text =>name,price =>white
                              * */
                              Positioned(
                                left: 3,
                                right: 10,
                                top: 70,
                                bottom: 5,
                                child: Container(
                                    margin: EdgeInsets.only(
                                        left: 0, top: 1, right: 0, bottom: 1),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          e.name,
                                          style: TextStyle(fontSize: 10),
                                        ))),
                              ),
                              Positioned(
                                left: 3,
                                right: 5,
                                top: 120,
                                bottom: 1,
                                child: Container(
                                    margin: EdgeInsets.only(
                                        left: 0, top: 1, right: 0, bottom: 0),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "RS " + e.price,
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ))),
                              )
                            ],
                          ),
                        ),
                      )))
                  .toList()),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_applications_rounded),
            label: 'Setting',
          ),
        ],
      ),
    );
  }

  Future<void> fetchAndSetList() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("type")
        .orderBy("itemIndex", descending: true)
        .get();

    for (final item in querySnapshot.docs) {
      itemList
          .add(CategoryModel.fromJson(item.data() as Map<dynamic, dynamic>));
    }
    fetchProduct(itemList.first.id);
  }

  Future<void> fetchProduct(String id) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("product")
        .where("id", isEqualTo: id)
        .get();

    for (final item in querySnapshot.docs) {
      productList
          .add(ProductModel.fromJson(item.data() as Map<dynamic, dynamic>));
    }
    setState(() {});
  }
}
// final imagefetch = Container(
//   margin: EdgeInsets.symmetric(vertical: 10),
//   alignment: FractionalOffset.topCenter ,
//   child: Image.network(.image[0]),
//
// )