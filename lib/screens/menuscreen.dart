import 'package:flutter/material.dart';
import 'package:flutter_test_application/data/Meals.dart';
import 'package:flutter_test_application/provider/mealsprovider.dart';
import 'package:provider/provider.dart';

class MenuSCreen extends StatefulWidget {
  const MenuSCreen({super.key});

  @override
  State<MenuSCreen> createState() => _MenuSCreenState();
}

class _MenuSCreenState extends State<MenuSCreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Consumer<MealsProvider>(
          builder: (context, provider, child) {
            return provider.isLoading
                ? getLoadingUI()
                : provider.error.isNotEmpty
                    ? getErrorUI(provider.error)
                    : getBodyUI(provider.meals);
          },
        ));
  }

  Widget getLoadingUI() {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text(
              "Some Error Happened !!! \n Please Try Again Later",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getErrorUI(String error) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          error,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 22,
          ),
        ),
      ),
    );
  }

  Widget getBodyUI(Meals meals){

    return GridView.count(
      
      crossAxisCount: 2,
      crossAxisSpacing: 15.0,
      mainAxisSpacing: 15.0, 
      padding: const EdgeInsets.all(10.0),

      children: List.generate(meals.meals.length, (index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
              image: NetworkImage(meals.meals[index]["strMealThumb"]),
              fit: BoxFit.contain,
            ),
          ),
          child: GestureDetector(
            onTap: () {
              _showDetails(meals.meals[index]);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      meals.meals[index]["strMeal"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    
    );

  }

  void _showDetails(Map<String, dynamic> meal) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(meal["strMeal"],),
          content:  SingleChildScrollView(
            child: Text(
              meal["strInstructions"],
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

}