import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task4/ui/screens/counter_page.dart';
import 'package:task4/ui/screens/favourites_drawer.dart';
import 'package:task4/ui/screens/home_page.dart';
import 'package:task4/ui/screens/login_screen.dart';

import '../data/data_source/data_source.dart';
import 'screens/profile_page.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  List<Widget> screens = const [MyHomePage(), CounterPage(), Profile()];
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      DataSource.isLoadingProfile = true;
      return true;
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
      return false;
    }
  }

  void getPage(int index) {
    setState(() {
      currentIndex = index;
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
            },
            icon: const Icon(Icons.list),
          ),
          centerTitle: true,
          title: currentIndex == 0
              ? const Text('Shop')
              : currentIndex == 1
                  ? const Text('Calculator')
                  : const Text('Profile'),
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
                                onPressed: () async {
                                  await signOut().then((value) {
                                    if (value) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()));
                                    }
                                  });
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
        drawer: FavouritesDrawer(favouriteList: DataSource.favouriteList),
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
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 40,
              ),
              label: 'Profile',
            ),
          ],
        ),
        body: screens[currentIndex],
      ),
    );
  }
}
