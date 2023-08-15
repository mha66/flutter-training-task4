import 'package:flutter/material.dart';
import 'package:task4/data/data_source/data_source.dart';
import 'package:task4/ui/widgets/product_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    if (DataSource.productList.isEmpty) {
      Future.delayed(Duration.zero, () async {
        await DataSource.getData();
        setState(() {
          DataSource.isLoading = false;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DataSource.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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
                      itemCount: DataSource.productList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return DisplayProduct(
                            product: DataSource.productList[index]);
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        // childAspectRatio: MediaQuery.of(context).size.width /
                        //     ((MediaQuery.of(context).size.height)-350),
                        mainAxisExtent: 205,
                        crossAxisSpacing: 10,
                        crossAxisCount: 2,
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
