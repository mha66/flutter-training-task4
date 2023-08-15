import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task4/ui/screens/counter_page.dart';
import 'package:task4/ui/screens/favourites_drawer.dart';
import 'package:task4/ui/screens/home_page.dart';

import '../data/data_source/data_source.dart';
import '../data/models/product_data.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  List<Widget> screens = const [MyHomePage(), CounterPage()];
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void getPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Product> favouriteList = [];

  void getFavourites() {
    setState(() {
      if (favouriteList.isNotEmpty) {
        favouriteList.clear();
      }
      for (var item in DataSource.productList) {
        if (item.isFavourite) {
          favouriteList.add(item);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: const Color(0xff432c2c),
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
              getFavourites();
            },
            icon: const Icon(Icons.list),
          ),
          centerTitle: true,
          title: currentIndex == 0 ? const Text('Shop') : const Text('Calculator'),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: const Text('Exit ?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  SystemNavigator.pop();
                                },
                                child: const Text('Yes')),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No')),
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        drawer: FavouritesDrawer(favouriteList: favouriteList),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          backgroundColor: const Color(0xff432c2c),
          unselectedItemColor: const Color(0xff8a7e7e),
          selectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          onTap: (index) {
            getPage(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
                size: 40,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box_rounded,
                size: 40,
              ),
              label: 'Counter',
            ),
          ],
        ),
        body: screens[currentIndex],
      ),
    );
  }
}
