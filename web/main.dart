import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

void main() => runApp(MyApp(products: fetchProducts())); 
List<Product> parseProducts(String responseBody) { 
   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>(); 
   return parsed.map<Product>((json) => Product.fromMap(json)).toList(); 
} 
Future<List<Product>> fetchProducts() async { 
   final response = await http.get('http://192.168.1.2:8000/shoes.json'); 
   if (response.statusCode == 200) { 
      return parseProducts(response.body); 
   } else { 
      throw Exception('Unable to fetch products from the REST API'); 
   } 
}


class MyApp extends StatelessWidget {
  final Future<List<Product>> products;
  MyApp({required Key key, required this.products}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
          title: 'Product Navigation demo home page', products: products, key: null,),
    );
  }
}
class MyHomePage extends StatelessWidget { 
   final String title; 
   final Future<List<Product>> products; 
   MyHomePage({required Key key, required this.title, required this.products}) : super(key: key); 
   
   // final items = Product.getProducts();
   @override 
   Widget build(BuildContext context) { 
      return Scaffold(
         appBar: AppBar(title: Text("Product Navigation")), 
         body: Center(
            child: FutureBuilder<List<Product>>(
               future: products, builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error); 
                  return snapshot.hasData ? ProductBoxList(items: snapshot.data) 
                  
                  // return the ListView widget : 
                  Center(child: CircularProgressIndicator()); 
               },
            ),
         )
      );
   }
}
class ProductBoxList extends StatelessWidget {
   final List<Product> items; 
   ProductBoxList({required Key key, required this.items}); 
   
   @override 
   Widget build(BuildContext context) {
      return ListView.builder(
         itemCount: items.length, 
         itemBuilder: (context, index) { 
            return GestureDetector( 
               child: ProductBox(item: items[index]), 
               onTap: () { 
                  Navigator.push(
                     context, MaterialPageRoute( 
                        builder: (context) => ProductPage(item: items[index]), 
                     ), 
                  ); 
               }, 
            ); 
         }, 
      ); 
   } 
} 
class ProductPage extends StatelessWidget { 
   ProductPage({required Key key, required this.item}) : super(key: key); 
   final Product item; 
   @override 
   Widget build(BuildContext context) {
      return Scaffold(
         appBar: AppBar(title: Text(this.item.name),), 
         body: Center( 
            child: Container(
               padding: EdgeInsets.all(0), 
               child: Column( 
                  mainAxisAlignment: MainAxisAlignment.start, 
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: <Widget>[
                     Image.asset("assets/appimages/" + this.item.image), 
                     Expanded( 
                        child: Container( 
                           padding: EdgeInsets.all(5), 
                           child: Column( 
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                              children: <Widget>[ 
                                 Text(this.item.name, style: 
                                    TextStyle(fontWeight: FontWeight.bold)), 
                                 Text(this.item.description), 
                                 Text("Price: " + this.item.price.toString()), 
                                  
                              ], 
                           )
                        )
                     ) 
                  ]
               ), 
            ), 
         ), 
      ); 
   } 
}

class ProductBox extends StatelessWidget {
   ProductBox({required Key key, required this.item}) : super(key: key); 
   final Product item; 
   
   Widget build(BuildContext context) {
      return Container(
         padding: EdgeInsets.all(2), height: 140, 
         child: Card(
            child: Row( 
               mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
               children: <Widget>[
                  Image.asset("assets/appimages/" + this.item.image), 
                  Expanded( 
                     child: Container( 
                        padding: EdgeInsets.all(5), 
                        child: Column( 
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                           children: <Widget>[ 
                              Text(this.item.name, style:TextStyle(fontWeight: FontWeight.bold)), 
                              Text(this.item.description), 
                              Text("Price: " + this.item.price.toString()), 
                           ], 
                        )
                     )
                  )
               ]
            ), 
         )
      ); 
   } 
}
