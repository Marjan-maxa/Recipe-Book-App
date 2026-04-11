import 'dart:convert';

import 'package:recipebook/data/model/recipe_model.dart';
import 'package:recipebook/domain/entities/recipe.dart';

import '../../core/app_strings.dart';
import 'package:http/http.dart' as http;
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
      throw Exception('Failed to load recipes');
    }
  }

  Future<List<Recipe>> searchRecipes(String query) async{

    final response = await http.get(Uri.parse('${AppStrings.baseUrl}/complexSearch?apiKey=${AppStrings.apiKey}&query=$query'));
    if(response.statusCode==200){
      final json = jsonDecode(response.body);
      final results = json['results'];
      return results.map<Recipe>((json) => RecipeModel.fromJson(json)).toList();

    }else{
      throw Exception('Failed to search recipes');
    }
  }
}