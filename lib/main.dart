import 'package:flutter/material.dart';

// Lab 3 - Category Page
// Author: Youhao Yu
// Student ID: 040795365
// Date: 2025-05-27
// Purpose: Display categorized food images using Column, Row, Stack, and CircleAvatar

void main() {
  runApp(const MyApp());
}

// Root widget of the app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 3 - Category Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const CategoryPage(),
    );
  }
}

// Main category page
class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  // Helper method to build an image with text under it using Stack
  Widget buildImageWithTextBelow(String label, String imagePath, Color textColor) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: 50,
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ],
    );
  }

  // Section title formatting
  Widget buildSectionTitle(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // Top App Bar with centered title
      appBar: AppBar(
        title: const Text(
          'BROWSE CATEGORIES',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 1.5,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Introductory text
            const Text(
              "Not sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories.",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 14),
            ),

            // Section 1: Meat
            const SizedBox(height: 10),
            Center(child: buildSectionTitle("BY MEAT")),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: const AssetImage("images/Beef.jpeg"),
                      radius: 50,
                    ),
                    const Text(
                      "BEEF",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        //backgroundColor: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: const AssetImage("images/Chicken.webp"),
                      radius: 50,
                    ),
                    const Text(
                      "CHICKEN",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        //backgroundColor: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: const AssetImage("images/Pork.webp"),
                      radius: 50,
                    ),
                    const Text(
                      "PORK",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        //backgroundColor: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: const AssetImage("images/Seafood.jpeg"),
                      radius: 50,
                    ),
                    const Text(
                      "SEAFOOD",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        //backgroundColor: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Section 2: Course
            Center(child: buildSectionTitle("BY COURSE")),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildImageWithTextBelow("Main Dishes", "images/Maindishes.jpeg", Colors.black),
                buildImageWithTextBelow("Salad Recipes", "images/Salad.webp", Colors.black),
                buildImageWithTextBelow("Side Dishes", "images/SideDishes.webp", Colors.black),
                buildImageWithTextBelow("Crockpot", "images/Crockpot.webp", Colors.black),
              ],
            ),

            // Section 3: Dessert
            Center(child: buildSectionTitle("BY DESSERT")),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildImageWithTextBelow("Ice Cream", "images/IceCream.webp", Colors.black),
                buildImageWithTextBelow("Brownies", "images/Brownies.webp", Colors.black),
                buildImageWithTextBelow("Pies", "images/Pies.webp", Colors.black),
                buildImageWithTextBelow("Cookies", "images/Cookies.jpeg", Colors.black),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
