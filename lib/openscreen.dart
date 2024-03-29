import 'package:flutter/material.dart';

class openscreen extends StatelessWidget {
  const openscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Pulkit'),
            accountEmail: Text('pulkitsoni2001@gmail.com'),
            currentAccountPicture: FlutterLogo(),
          ),
          ListTile(
            title: Text('Home'),
          ),
          ListTile(
            title: Text('Cart'),
          ),
          ListTile(
            title: Text('orders'),
          ),
          ListTile(
            title: Text('settings'),
          ),
        ],
      )),
      appBar: AppBar(

          // leading: const IconButton(onPressed: null, icon: Icon(Icons.menu),tooltip: 'Navigations menu',),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: const IconButton(
                onPressed: null,
                icon: Icon(Icons.search),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: const IconButton(
                onPressed: null,
                icon: Icon(Icons.shopping_cart),
              ),
            ),
          ],
          title: Text(
            "The Village Mart",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.amberAccent),
    );
  }
}
