import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:map/bottom_nav.dart';
import 'package:map/product_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MAP',
      home: BottomNav(),
    );
  }
}

class TestClass extends StatefulWidget {
  const TestClass({Key? key}) : super(key: key);

  @override
  State<TestClass> createState() => _TestClassState();
}

class _TestClassState extends State<TestClass> {
  getData() async {
    print("working");
    var response = await http.get(
      Uri.parse(
          "https://32a2c56e6eeee31171cc4cb4349c2329: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@monark-clothings.myshopify.com/admin/api/2021-07/products.json"),
    );
    print("working");
    var data = jsonDecode(response.body);
    return data["products"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API Testing"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: getData(),
            builder:
                (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  itemCount: (snapshot.data as List).length,
                  itemBuilder: (context, i) {
                    return card(
                      context,
                      snapshot.data[i]["images"][0]["src"].toString(),
                      snapshot.data[i]["title"].toString(),
                      snapshot.data[i]["variants"][0]["price"].toString(),
                      snapshot.data[i]["body_html"].toString(),
                    );
                  },
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 3 / 6),
                );
              }
              else
                {
                  return CircularProgressIndicator();
                }
            }),
      ),
    );
  }
}

Widget card(context, image, title, price, description) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductPage(
            title: title,
            image: image,
            price: price,
            description: description,
          ),
        ),
      );
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CachedNetworkImage(
              imageUrl: image,
              height: MediaQuery.of(context).size.height * 0.25,
              placeholder: (context, string) {
                return Image.asset("assets/loading.gif");
              }),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(fontSize: 17),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            price,
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ],
    ),
  );
}
