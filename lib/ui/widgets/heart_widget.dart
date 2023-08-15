import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/product_data.dart';

class Heart extends StatefulWidget {
  const Heart({super.key, required this.product});

  final Product product;

  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> {
  //bool favourite = false;
  void heartPressed() {
    setState(() {
      widget.product.isFavourite = !widget.product.isFavourite;
      //favourite = !favourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        heartPressed();
      },
      icon: Icon(
        widget.product.isFavourite
            ? CupertinoIcons.heart_fill
            : CupertinoIcons.heart,
        color: const Color(0xFFDC3030),
      ),
      alignment: Alignment.topRight,
      splashRadius: 1,
    );
  }
}
