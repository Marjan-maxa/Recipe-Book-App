import 'dart:convert';

import 'package:recipebook/data/model/recipe_model.dart';
import 'package:recipebook/domain/entities/recipe.dart';

import '../../core/app_strings.dart';
import 'package:http/http.dart' as http;

import '../model/recipe_detaild_model.dart';
class ApiService {
  Future<List<Recipe>> getRecipeCategories(String category) async{
    final url = category == 'All'
        ? '${AppStrings.baseUrl}/complexSearch?apiKey=${AppStrings.apiKey}'
        : '${AppStrings.baseUrl}/complexSearch?apiKey=${AppStrings.apiKey}&cuisine=$category';
    final response = await http.get(Uri.parse(url));
    if(response.statusCode==200){
      final json = jsonDecode(response.body);
      final results = json['results'];
      return results.map<Recipe>((json) => RecipeModel.fromJson(json)).toList();

    }else{
      print("STATUS CODE: ${response.statusCode}");
      print("BODY: ${response.body}");
      throw Exception('Failed to load recipes');
    }
  }

  Future<List<Recipe>> searchRecipes(String query) async {

    final url =
        '${AppStrings.baseUrl}/complexSearch'
        '?apiKey=${AppStrings.apiKey}'
        '&query=${Uri.encodeComponent(query)}'
        '&addRecipeInformation=true';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final results = json['results'];

      return List<Recipe>.from(
        results.map((item) => RecipeModel.fromJson(item)),
      );
    } else {
      throw Exception('Failed to search recipes');
    }
  }
  Future<RecipeDetails> getRecipeDetails(String id) async {
    final url =
        '${AppStrings.baseUrl}/$id/information?apiKey=${AppStrings.apiKey}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return RecipeDetails.fromJson(data);
    } else {
      print("STATUS CODE: ${response.statusCode}");
      print("BODY: ${response.body}");
      throw Exception('Failed to load recipe details');
    }
  }

}