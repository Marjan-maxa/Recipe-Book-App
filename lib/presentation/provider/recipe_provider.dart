import 'package:flutter/material.dart';
import 'package:recipebook/domain/entities/recipe.dart';

import '../../data/model/recipe_detaild_model.dart';
import '../../data/service/api_service.dart';

class RecipeProvider extends ChangeNotifier{
  ApiService _apiService=ApiService();
  List<Recipe>_categoryRecipe=[];
  List<Recipe>_searchRecipe=[];
  List<Recipe>get categoryRecipe=>_categoryRecipe;
  List<Recipe>get searchRecipe=>_searchRecipe;
  RecipeDetails? _recipeDetails;
  RecipeDetails? get recipeDetails => _recipeDetails;
bool _isLoading=false;
bool get isLoading=>_isLoading;

Future<void>fetchCategoryRecipe(String category)async{
  _isLoading=true;
  notifyListeners();
  try {
     _categoryRecipe = await _apiService.getRecipeCategories(category);

  }catch(e){
    print('Error fetching category recipes: $e');
  }finally{
    _isLoading=false;
    notifyListeners();
  }

  }

  Future<void>searchRecipes(String query)async{
    _isLoading=true;
    notifyListeners();
    try {
       _searchRecipe = await _apiService.searchRecipes(query);

    }catch(e){
      print('Error searching recipes: $e');
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }
  Future<void>fetchRecipeDetails(String id)async{
    _isLoading=true;
    notifyListeners();
    try {
      _recipeDetails =await _apiService.getRecipeDetails(id);
    }catch(e){
      print('Error fetching recipe details: $e');
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }

}
