import 'package:flutter/material.dart';
import 'package:task4/data/models/product_data.dart';
import 'package:task4/ui/widgets/heart_widget.dart';

class DisplayProduct extends StatelessWidget {
  final Product product;

  const DisplayProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 130,
          width: 170,
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blue,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(product.thumbnail),
              )),
          child: Align(
            alignment: Alignment.topRight,
            child: Heart(product: product,),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          product.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF6D777F),
          ),
        ),
        Text(
          '\$${product.price.toString()}',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 19,
          ),
        ),
      ],
    );
  }
}
