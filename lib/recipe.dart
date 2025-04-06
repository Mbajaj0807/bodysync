class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  Recipe({required this.id, required this.title, required this.description, required this.imageUrl});

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
    );
  }
}
