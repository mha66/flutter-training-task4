import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task4/ui/screens/counter_page.dart';
import 'package:task4/ui/screens/favourites_drawer.dart';
import 'package:task4/ui/screens/home_page.dart';
import 'package:task4/ui/screens/login_screen.dart';

import '../cubit/app_cubit.dart';
import '../data/data_source/data_source.dart';
import 'screens/profile_page.dart';

class Layout extends StatelessWidget {
  Layout({super.key});

  final List<Widget> screens = const [MyHomePage(), CounterPage(), Profile()];


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<AppCubitA, AppStateA>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: const Color(0xff300046),
              leading: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                icon: const Icon(Icons.list),
              ),
              centerTitle: true,
              title: context.read<AppCubitA>().currentPageIndex == 0
                  ? const Text('Shop')
                  : context.read<AppCubitA>().currentPageIndex == 1
                  ? const Text('Calculator')
                  : const Text('Profile'),
              actions: [
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: const Text('Log out ?'),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      await context.read<AppCubitA>().signOut().then((value) {
                                        if (value) {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage()));
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
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: BottomNavigationBar(
                  currentIndex: context.read<AppCubitA>().currentPageIndex,
                  backgroundColor: const Color(0xff300046),
                  unselectedItemColor: const Color(0xFF8391A1),
                  selectedItemColor: Colors.white,
                  selectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  onTap: (index) {
                    context.read<AppCubitA>().getPage(index);
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
              ),
            ),
            extendBody: true,
            body: screens[context.read<AppCubitA>().currentPageIndex],
          );
        },
      ),
    );
  }
}

// Future<bool> signOut() async {
//   try {
//     await FirebaseAuth.instance.signOut();
//     return true;
//   } catch (error) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(error.toString())));
//     return false;
//   }
// }

// void getPage(int index) {
//   setState(() {
//     currentIndex = index;
//   });
// }