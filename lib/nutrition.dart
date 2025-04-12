import 'package:flutter/material.dart';
import 'recipe_services.dart';
import 'recipe.dart';
import 'recipe_detail_page.dart';

class Nutrition extends StatelessWidget {
  final RecipeService recipeService = RecipeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(35,35,35,1),
      appBar: AppBar(title: Text('Recipes',style: TextStyle(color: Color.fromRGBO(137, 108, 254, 1)),),backgroundColor: Color.fromRGBO(35,35,35,1),
      iconTheme: IconThemeData(color: Color.fromRGBO(137, 108, 254, 1)),),
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

          return ListView.builder( // <--- START OF THE LISTVIEW
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                color: Colors.grey[800],
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecipeDetailPage(recipe: recipe)),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          recipe.imageUrl.startsWith('assets/')
                              ? SizedBox(

                            width: 500,
                            height: 250,

                            child: Image.asset(
                              width: 1000,
                              recipe.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey));
                              },
                            ),
                          )
                              : SizedBox(
                            width: 1000,
                            height: 120,
                            child: Image.network(
                              recipe.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey));
                              },
                            ),
                          ),
                          SizedBox(height: 8.0),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      recipe.title,
                                      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      recipe.description,
                                      style: TextStyle(color: Colors.grey[400],fontSize: 22),
                                    ),
                                  ],
                                ),
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 16,vertical:6),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('🍞Carbs:',style: TextStyle(fontSize: 20,color: Colors.white)),
                                        SizedBox(width:6),
                                        Text(
                                          recipe.carbs,
                                          style: TextStyle(fontSize: 20,color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height:15,width:20),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.teal.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('💪 Protein :', style: TextStyle(fontSize: 20,color: Colors.white),),
                                        SizedBox(width: 6),
                                        Text(
                                          recipe.protein,
                                          style: TextStyle(fontSize: 20, color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.purple.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('🔥', style: TextStyle(fontSize: 20)),
                                        SizedBox(width: 6),
                                        Text(
                                          recipe.calories,
                                          style: TextStyle(fontSize: 20, color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),



                                ],
                              ),





                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
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
        calories:'',
        protein:'',
        carbs:'',
      ),
      Recipe(
        id: '',
        title: 'Chocolate Cake',
        description: 'Rich and moist chocolate cake',
        imageUrl: 'assets/choco.jpg',
        calories:'',
        protein:'',
        carbs:'',
      ),
      Recipe(id: ' ',
          title: 'Smoothie',
          description: 'Healthy homemade smoothie',
          imageUrl: 'assets/smoothie.jpg',
        calories:'122 kcal',
        protein:'',
        carbs:'',),

      Recipe(id: '',
          title: 'Chicken sandwich',
          description: 'High protein chicken sandwich',
          imageUrl: 'assets/chickensandwich.jpg',
        calories:'367 kcal',
        protein:'',
        carbs:'',),
      Recipe(id: '',
          title: 'White Bean and Veggie Salad',
          description: 'Loaded with veggies and creamy beans',
          imageUrl: 'assets/salad.jpg',
        calories:'',
        protein:'',
        carbs:'',),
      Recipe(id: '',
          title: 'Paneer Fried Rice',
          description: 'Soft and delicious paneer with rice',
          imageUrl: 'assets/paneerfried.jpg',
        calories:'',
        protein:'',
        carbs:'',),
      Recipe(id: '',
          title: 'Omelette',
          description: 'Low calorie omelette',
          imageUrl: 'assets/omelette.jpeg',
        calories:'',
        protein:'',
        carbs:'',),
      Recipe(id: '',
          title: 'Fruit Custard',
          description: 'Low-fat yummy fruit custard',
          imageUrl: 'assets/custard.jpg',
        calories:'',protein:'',
        carbs:'',),
      Recipe(id: '',
          title: 'Vegan Mediterranean Wrap',
          description: 'Low-calorie tangy  wrap',
          imageUrl: 'assets/wrap.jpeg',
        calories:'',protein:'',
        carbs:'',),
      Recipe(id: '',
          title: 'Chicken Biryani',
          description: 'Spicy and healthy chicken biryani',
          imageUrl: 'assets/biryani.jpg',
        calories:'',protein:'',
        carbs:'',)
    ];

    for (var recipe in recipesToAdd) {
      recipeService.addRecipe(recipe);
    }
  }

}