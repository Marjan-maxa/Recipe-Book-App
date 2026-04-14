import 'package:recipebook/domain/entities/recipe.dart';

class RecipeModel extends Recipe{
  RecipeModel({required super.id, required super.title, required super.image});

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return RecipeModel(

      id: json['id'].toString(),
      title: json['title'],
        image: (json['image'] ?? '')
            .replaceAll('312x231', '636x393'),
    );

  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
    };
  }
}