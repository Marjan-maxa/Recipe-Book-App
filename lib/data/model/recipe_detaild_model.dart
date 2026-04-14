import 'ingredient_model.dart';

class RecipeDetails {
  final String id;
  final String title;
  final String image;
  final String summary;
  final int readyTime;
  final int servings;

  final List<Ingredient> ingredients; // 🔥 ADD THIS

  RecipeDetails({
    required this.id,
    required this.title,
    required this.image,
    required this.summary,
    required this.readyTime,
    required this.servings,
    required this.ingredients, // 🔥 ADD
  });

  factory RecipeDetails.fromJson(Map<String, dynamic> json) {
    return RecipeDetails(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      summary: json['summary'] ?? '',
      readyTime: json['readyInMinutes'] ?? 0,
      servings: json['servings'] ?? 0,

      /// 🔥 MAIN FIX
      ingredients: (json['extendedIngredients'] as List?)
          ?.map((e) => Ingredient.fromJson(e))
          .toList() ??
          [],
    );
  }
}