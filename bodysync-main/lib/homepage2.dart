import 'package:flutter/material.dart';
import 'recipe_services.dart';
import 'recipe.dart';
import 'recipe_detail_page.dart';

class HomePage extends StatelessWidget {
  final RecipeService recipeService = RecipeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recipes')),
      body: StreamBuilder<List<Recipe>>(
        stream: recipeService.getRecipes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No recipes found.'));
          }

          List<Recipe> recipes = snapshot.data!;

          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return ListTile(
                leading: recipe.imageUrl.startsWith('assets/')
                    ? Image.asset(recipe.imageUrl, width: 50, height: 50, fit: BoxFit.cover)
                    : Image.network(
                  recipe.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.image_not_supported, size: 50, color: Colors.grey);
                  },
                ),
                title: Text(recipe.title),
                subtitle: Text(recipe.description),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecipeDetailPage(recipe: recipe)),
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
      Recipe(id: ' ',
          title: 'Smoothie',
          description: 'Healthy homemade smoothie',
          imageUrl: 'assets/smoothie.jpg'),
      Recipe(id: '',
          title: 'Chicken sandwich',
          description: 'High protein chicken sandwich',
          imageUrl: 'assets/chickensandwich.jpg'),
      Recipe(id: '',
          title: 'White Bean and Veggie Salad',
          description: 'Loaded with veggies and creamy beans',
          imageUrl: 'assets/salad.jpg'),
      Recipe(id: '',
          title: 'Paneer Fried Rice',
          description: 'Soft and delicious paneer with rice',
          imageUrl: 'assets/paneerfried.jpg'),
      Recipe(id: '',
          title: 'Omelette',
          description: 'Low calorie omelette',
          imageUrl: 'assets/omelette.jpg')
    ];

    for (var recipe in recipesToAdd) {
      recipeService.addRecipe(recipe);
    }
  }

}


