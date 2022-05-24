import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/cart/cart_screen.dart';

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
      body: SafeArea(
        child: CustomScrollView(
          controller: controllerTypeDataList,
          slivers: [
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
                          return const cart_screen();
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
                          margin: const EdgeInsets.only(top: 10, bottom: 10,left: 5,right: 5),
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

              GridView.builder(controller:controllerTypeDataList,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder:(context,index){

                  return InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      // width: size.width * 0.9,
                      // height: size.height * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.purple.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.network(productList[index].image[0]),
                    ),
                  );
              },itemCount: productList.length, )

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

  Future<void> fetchProduct(String id)async{
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
class ProductModel{
 final String id;
 final String productId;
 final String name;
 final List<dynamic> image;
 final String mrp;
 final String productType;
 final String price;
 final String productBy;
 final String storeName;
 final String rating;
 final String shortDescription;
 final Map<dynamic, dynamic> productData;
 final List<dynamic> location;
 final List<dynamic> tags;
 final bool isAvailable;
 final String totalProductCount;

 ProductModel(
      {required this.id,
      required this.productId,
      required this.name,
      required this.image,
      required this.mrp,
      required this.productType,
      required this.price,
      required this.productBy,
      required this.storeName,
      required this.rating,
      required this.shortDescription,
      required this.productData,
      required this.location,
      required this.tags,
      required this.isAvailable,
      required this.totalProductCount});

 factory ProductModel.fromJson(Map<dynamic, dynamic> value) {
   return ProductModel(
       id: value["id"]??"001",
       productId: value["productId"]??"0001",
       name: value["name"]??"",
       image: value["image"]??"",
       mrp: value["mrp"]??"",
       productType: value["productType"]??"",
       price: value["price"]??"",
       productBy: value["productBy"]??"",
       storeName: value["storeName"]??"",
       rating: value["rating"]??"",
       shortDescription: value["shortDescription"]??"",
       productData: value["productData"]??"",
       location: value["location"]??"",
       totalProductCount: value["totalProductCount"]??"",
       tags: value["tags"]??"",
       isAvailable: value["isAvailable"]??"");
 }
}
class CategoryModel {
  final String name;
  final String image;
  final String id;
  final int itemIndex;

  CategoryModel(
      {required this.name,
      required this.id,
      required this.image,
      required this.itemIndex});

  factory CategoryModel.fromJson(Map<dynamic, dynamic> json) {
    return CategoryModel(
        name: json['name'],
        image: json['image'],
        id: json['id'],
        itemIndex: json['itemIndex']);
  }
}

class home_offers {
  final String name;
  final String link;
  final int id;

  home_offers(this.name, this.link, this.id);
}
