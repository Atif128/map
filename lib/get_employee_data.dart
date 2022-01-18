import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:map/bottom_nav.dart';
import 'package:map/product_page.dart';

import 'main.dart';

class EmployeeClass extends StatefulWidget {
  const EmployeeClass({Key? key}) : super(key: key);

  @override
  State<EmployeeClass> createState() => _EmployeeClassState();
}

class _EmployeeClassState extends State<EmployeeClass> {
  get http => null;

  getData() async {
    print("working");
    var response = await http.get(
      Uri.parse(
          "https://32a2c56e6eeee31171cc4cb4349c2329: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@monark-clothings.myshopify.com/admin/api/2021-07/products.json"),
    );
    var data = jsonDecode(response.body);
    return data["data"];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: (snapshot.data as List).length,
                itemBuilder: (context, i) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: CachedNetworkImage(
                            imageUrl: snapshot.data[i]["image"].toString(),
                            height: MediaQuery.of(context).size.height * 0.25,
                            placeholder: (context, string) {
                              return Image.asset("assets/loading.gif");
                            }),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          snapshot.data[i]["employee_name"].toString(),
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          snapshot.data[i]["department"].toString(),
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  );
                  // snapshot.data[i]["employee_id"].toString(),
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 6),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
