import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task4/cubit/app_cubit.dart';
import 'package:task4/ui/widgets/product_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AppCubitA, AppStateA>(
      listener: (context, state) {
        if (state is ProductsErrorState) {
          showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              content: Text('Try again later'),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ProductsErrorState) {
          return const Center(child: Text('Error'));
        } else if (state is ProductsDoneState ||
            context.read<AppCubitA>().productList.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 7, right: 25, top: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'New Products',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                      Text(
                        'See All',
                        style: TextStyle(
                          color: Color(0xFF6E6E6E),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 55),
                Expanded(
                  child: GridView.builder(
                    itemCount: context.read<AppCubitA>().productList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return DisplayProduct(
                          product:
                              context.read<AppCubitA>().productList[index]);
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 205,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    ));
  }
}

