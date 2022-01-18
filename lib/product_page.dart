import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;


class ProductPage extends StatefulWidget {
  final String title, image, price, description;

  const ProductPage(
      {Key? key,
      required this.title,
      required this.image,
      required this.price,
      required this.description})
      : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.image,
                  height: MediaQuery.of(context).size.height * 0.4,
                  placeholder: (context, string) {
                    return Image.asset("assets/loading.gif");
                  },
                ),
              ],
            ),
            Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Text(widget.price),
            Html(data: widget.description,)
          ],
        ),
      ),
    );
  }
}
