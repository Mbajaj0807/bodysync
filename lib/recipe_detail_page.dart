import 'package:flutter/material.dart';
import 'recipe.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        backgroundColor: Color.fromRGBO(137, 108, 245, 1),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child:
            recipe.imageUrl.startsWith('assets/')
                ? Image.asset(
                  recipe.imageUrl,
                  width: double.infinity,
                  height: 500,
                  fit: BoxFit.cover,
                )
                : Image.network(
                  recipe.imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image_not_supported,
                      size: 100,
                      color: Colors.grey,
                    );
                  },
                ),
      ),
    );
  }
}
