import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../../core/app_strings.dart';
import '../provider/recipe_provider.dart';
import '../widgets/ingredient_item.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({super.key, required this.id});
  final String id;

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecipeProvider>().fetchRecipeDetails(widget.id);
    });
  }

  String cleanHtml(String html) {
    return html.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RecipeProvider>(
        builder: (context, provider, child) {

          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.recipeDetails == null) {
            return const Center(
              child: Text(AppStrings.failedToLoadRecipe),
            );
          }

          final recipe = provider.recipeDetails!;

          return Stack(
            children: [

              /// 🌄 BACKGROUND IMAGE
              SizedBox(
                height: 320,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: recipe.image,
                  fit: BoxFit.cover,
                ),
              ),

              /// 🔙 BACK BUTTON
              Positioned(
                top: 45,
                left: 16,
                child: _circleButton(Icons.arrow_back, () {
                  Navigator.pop(context);
                }),
              ),

              /// 🔖 BOOKMARK BUTTON
              Positioned(
                top: 45,
                right: 16,
                child: _circleButton(Icons.bookmark_border, () {}),
              ),

              /// 📦 DRAGGABLE SHEET
              DraggableScrollableSheet(
                initialChildSize: 0.65,
                minChildSize: 0.55,
                maxChildSize: 0.95,

                builder: (context, scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),

                    child: ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(16),
                      children: [

                        /// HANDLE BAR
                        Center(
                          child: Container(
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// TITLE + RATING
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                recipe.title,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Row(
                              children: [
                                Icon(Icons.star, color: Colors.orange),
                                SizedBox(width: 4),
                                Text("4.5"),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        /// TIME + SERVINGS
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 18),
                            const SizedBox(width: 5),
                            Text("${recipe.readyTime} mins"),

                            const SizedBox(width: 20),

                            const Icon(Icons.restaurant, size: 18),
                            const SizedBox(width: 5),
                            Text("${recipe.servings} servings"),
                          ],
                        ),

                        const SizedBox(height: 20),

                        /// INGREDIENTS TITLE
                        const Text(
                          "Ingredients",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// INGREDIENT LIST
                        SizedBox(
                          height: 90,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: recipe.ingredients.length,
                            itemBuilder: (context, index) {
                              final item = recipe.ingredients[index].name;
                              return IngredientItem(name: item);
                            },
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// DESCRIPTION
                        const Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          cleanHtml(recipe.summary ?? ''),
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: IconButton(
        icon: Icon(icon),
        onPressed: onTap,
      ),
    );
  }
}