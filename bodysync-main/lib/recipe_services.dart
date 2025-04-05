import 'package:cloud_firestore/cloud_firestore.dart';
import 'recipe.dart';

class RecipeService {
  final CollectionReference recipesCollection = FirebaseFirestore.instance.collection('recipes');

  // Add Recipe
  Future<void> addRecipe(Recipe recipe) async {
    await recipesCollection.add(recipe.toMap());
  }

  // Fetch Recipes
  Stream<List<Recipe>> getRecipes() {
    return recipesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Recipe.fromFirestore(doc.id, doc.data() as Map<String, dynamic>)).toList();
    });
  }
}
