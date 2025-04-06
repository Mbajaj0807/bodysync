import 'package:flutter/material.dart';
import 'recipe_services.dart';
import 'recipe.dart';
import 'recipe_detail_page.dart';

class Nutrition extends StatelessWidget {
  final RecipeService recipeService = RecipeService();

  @override
  Widget build(BuildContext context) {
    print("Building Nutrition page...");

    return Scaffold(
      appBar: AppBar(title: Text('Recipes')),
      backgroundColor: Color.fromRGBO(35, 35, 35, 1),
      body: StreamBuilder<List<Recipe>>(
        stream: recipeService.getRecipes(),
        builder: (context, snapshot) {
          print("Snapshot connection state: ${snapshot.connectionState}");
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("Loading recipes...");
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print("Error loading recipes: ${snapshot.error}");
            return Center(child: Text('Error loading recipes'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print("No recipes found.");
            return Center(child: Text('No recipes found.'));
          }

          List<Recipe> recipes = snapshot.data!;
          print("Loaded ${recipes.length} recipes");

          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              print("Building list item for recipe: ${recipe.title}");

              return ListTile(
                leading:
                    recipe.imageUrl.startsWith('assets/')
                        ? Image.asset(
                          recipe.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                        : Image.network(
                          recipe.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            print("Image failed to load: $error");
                            return Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey,
                            );
                          },
                        ),
                title: Text(
                  recipe.title,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  recipe.description,
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  print("Navigating to details for ${recipe.title}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailPage(recipe: recipe),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addRecipe(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _addRecipe(BuildContext context) {
    print("Adding predefined recipes to database...");
    final List<Recipe> recipesToAdd = [
      Recipe(
        id: '',
        title: 'Pasta',
        description: 'Delicious homemade pasta',
        imageUrl: 'assets/pasta.jpg',
      ),
      Recipe(
        id: '',
        title: 'Chocolate Cake',
        description: 'Rich and moist chocolate cake',
        imageUrl: 'assets/choco.jpg',
      ),
      Recipe(
        id: '',
        title: 'Smoothie',
        description: 'Healthy homemade smoothie',
        imageUrl: 'assets/smoothie.jpg',
      ),
      Recipe(
        id: '',
        title: 'Chicken sandwich',
        description: 'High protein chicken sandwich',
        imageUrl: 'assets/chickensandwich.jpg',
      ),
      Recipe(
        id: '',
        title: 'White Bean and Veggie Salad',
        description: 'Loaded with veggies and creamy beans',
        imageUrl: 'assets/salad.jpg',
      ),
      Recipe(
        id: '',
        title: 'Paneer Fried Rice',
        description: 'Soft and delicious paneer with rice',
        imageUrl: 'assets/paneerfried.jpg',
      ),
      Recipe(
        id: '',
        title: 'Omelette',
        description: 'Low calorie omelette',
        imageUrl: 'assets/omelette.jpg',
      ),
    ];

    for (var recipe in recipesToAdd) {
      print("Adding recipe: ${recipe.title}");
      recipeService.addRecipe(recipe);
    }
  }
}
