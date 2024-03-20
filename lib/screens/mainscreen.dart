import 'package:flutter/material.dart';
import 'package:flutter_test_application/provider/categoryprovider.dart';
import 'package:flutter_test_application/provider/mealsprovider.dart';
import 'package:flutter_test_application/screens/homescreen.dart';
import 'package:flutter_test_application/screens/menuscreen.dart';
import 'package:flutter_test_application/screens/userprofilescreen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  
  @override
  void initState() {
        final mealsProvider = Provider.of<MealsProvider>(context, listen: false);
    mealsProvider.getMealFromAPI();

    //category
    final categoryProvider =
    Provider.of<CategoryProvide>(context, listen: false);
    categoryProvider.getCategoryAPI();
    super.initState();
  }
  int _currentPageIndex = 0;
  List<String> _appbar = ['HOME','MENU','USER'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text(_appbar[_currentPageIndex],style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),backgroundColor: Colors.black,centerTitle: true,),
      bottomNavigationBar: NavigationBar(
        
        backgroundColor: Colors.black,
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        
        indicatorColor: Colors.white,
        selectedIndex: _currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: '',
            
            
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
      body: <Widget>[
        const HomeScreen(),
        const MenuSCreen(),
        const UserScreen()
      ][_currentPageIndex],
    );
  }

  }
