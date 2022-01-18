import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


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
      child: Scaffold(
        appBar: AppBar(
          title: Text("Employee data"),
          centerTitle: true,
        ),
      ),
    );
  }
}
