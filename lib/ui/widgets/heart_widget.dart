import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:task4/data/data_source/data_source.dart';

import '../../data/models/product_data.dart';

class Heart extends StatefulWidget {
  const Heart({super.key, required this.product});

  final Product product;

  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> {
  void heartPressed() {
    setState(() {
      widget.product.isFavourite = !widget.product.isFavourite;
      if (widget.product.isFavourite) {
        DataSource.favouriteList.add(widget.product);
      } else {
        DataSource.favouriteList
            .removeWhere((item) => item.id == widget.product.id);
      }
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
