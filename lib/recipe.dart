class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String calories;
  final String protein;
  final String carbs;

  Recipe({required this.id, required this.title, required this.description, required this.imageUrl,required this.calories, required this.protein,required this.carbs});

  // Convert Recipe to Map (for Firebase)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }


  // Convert Firebase Document to Recipe
  factory Recipe.fromFirestore(String id, Map<String, dynamic> data) {
    return Recipe(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      calories:data['calories'] ?? '',
      protein:data['protein'] ?? '',
      carbs:data['carbs']??'',
    );
  }
}
