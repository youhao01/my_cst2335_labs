import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Browser',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const RecipePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 4),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 1. BROWSE CATEGORIES title
            const Text(
              'BROWSE CATEGORIES',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),

            // 2. Description text - left aligned
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Not sure about exactly which recipe you\'re looking for? Do a search, or dive into our most popular categories.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),

            // 3. BY MEAT heading
            const Text(
              'BY MEAT',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),

            // 4. Meat category images (text overlapping in center)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Beef
                meatCategoryItem('images/Beef.jpeg', 'BEEF'),
                // Chicken
                meatCategoryItem('images/Chicken.webp', 'CHICKEN'),
                // Pork
                meatCategoryItem('images/Pork.webp', 'PORK'),
                // Seafood
                meatCategoryItem('images/Seafood.jpeg', 'SEAFOOD'),
              ],
            ),

            // 5. BY COURSE heading
            const Text(
              'BY COURSE',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),

            // 6. Course category images with text below (not overlapping)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Main Dishes
                columnItem('images/Maindishes.jpeg', 'Main Dishes'),
                // Salad Recipes
                columnItem('images/Salad.webp', 'Salad Recipes'),
                // Side Dishes
                columnItem('images/SideDishes.webp', 'Side Dishes'),
                // Crockpot
                columnItem('images/Crockpot.webp', 'Crockpot'),
              ],
            ),

            // 7. BY DESSERT heading
            const Text(
              'BY DESSERT',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),

            // 8. Dessert category images with text below (not overlapping)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Ice Cream
                columnItem('images/IceCream.webp', 'Ice Cream'),
                // Brownies
                columnItem('images/Brownies.webp', 'Brownies'),
                // Pies
                columnItem('images/Pies.webp', 'Pies'),
                // Cookies
                columnItem('images/Cookies.jpeg', 'Cookies'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for meat categories (text centered over image)
  Widget meatCategoryItem(String imagePath, String label) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          radius: 45,
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  // Helper method for course and dessert categories (text below image, not overlapping)
  Widget columnItem(String imagePath, String label) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          radius: 45,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}