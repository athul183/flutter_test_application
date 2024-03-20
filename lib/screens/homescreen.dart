import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/data/Category.dart';
import 'package:flutter_test_application/data/Meals.dart';
import 'package:flutter_test_application/provider/categoryprovider.dart';
import 'package:flutter_test_application/provider/mealsprovider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 2.5,
              
            ),
            const Padding(
              padding:  EdgeInsets.only(left: 15),
              child: Text(
                "Today’s Meals",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
            Consumer<MealsProvider>(
              builder: (context, provider, child) {
                return provider.isLoading
                    ? getLoading()
                    : provider.error.isNotEmpty
                        ? getErrorUI(provider.error)
                        : getMealsBodyUI(provider.meals);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Popular Categories",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
            const SizedBox(height: 15,),

            Consumer<CategoryProvide> (builder: (context, provider, child){
              return provider.isLoading
                ? getLoading()
                : provider.error.isNotEmpty
                        ? getErrorUI(provider.error)
                        : getCategoryBodyUI(provider.category);
            })

            
          ],
        ),
      ),
    );
  }

  Widget getLoading() {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text(
              "Some Error Happened !!! \n Please Try Again Later",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getErrorUI(String error) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
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

  Widget getMealsBodyUI(Meals meals) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.47,
      child: CarouselSlider.builder(
        options: CarouselOptions(
          reverse: true,
          height: MediaQuery.of(context).size.height * 0.53,
          autoPlay: true,
          enlargeCenterPage: true,
          
        ),
        itemCount: meals.meals.length,
        itemBuilder: (context, index, realIndex) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                
                image: DecorationImage(
                  image: NetworkImage(meals.meals[index]['strMealThumb']),
                  fit: BoxFit.contain,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.3),
                    ],
                  ),
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
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },),);}

   Widget getCategoryBodyUI(Category category) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0, 
        padding: const EdgeInsets.all(10.0),
        children: List.generate(category.categories.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.12,
                    width: MediaQuery.of(context).size.height * 0.12,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white
                        ,
                        image: DecorationImage(
                          image: NetworkImage(
                              category.categories[index].strCategoryThumb),
                          fit: BoxFit.cover,
                        )),
                  ),
                  const SizedBox(height: 5,),
                  Text(
                    category.categories[index].strCategory,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ]
              )
            )
          );
        }),


        ),
      // child: ListView.builder(
        
      //   scrollDirection: Axis.vertical,
      //   itemCount: category.categories.length,
      //   itemBuilder: (context, index) {
          
      //   },
      // ),
    );
  }
}