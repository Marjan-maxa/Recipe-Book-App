import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../provider/recipe_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,

      /// 🔝 APP BAR SEARCH
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: TextField(
          controller: _searchController,
          textInputAction: TextInputAction.search,
          decoration: const InputDecoration(
            hintText: 'Search recipes...',
            border: InputBorder.none,
          ),
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              context.read<RecipeProvider>().searchRecipes(value.trim());
            }
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              _searchController.clear();
            },
            icon: const Icon(Icons.cancel),
          ),
        ],
      ),

      /// 📦 BODY
      body: Consumer<RecipeProvider>(
        builder: (context, provider, child) {

          /// 🔄 LOADING STATE
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          /// 🟡 EMPTY BEFORE SEARCH
          if (!provider.isLoading && _searchController.text.isEmpty) {
            return const Center(
              child: Text(
                "Search for tasty recipes 🍜",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          /// ❌ NO RESULT STATE
          if (provider.searchRecipe.isEmpty) {
            return const Center(
              child: Text(
                "No recipes found 😢",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          /// ✅ RESULT LIST
          return ListView.builder(

            padding: const EdgeInsets.all(12),
            itemCount: provider.searchRecipe.length,
            itemBuilder: (context, index) {
              print("IMAGE URL: ${provider.searchRecipe[index].image}");
              final recipe = provider.searchRecipe[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),

                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),

                  /// 🖼 IMAGE
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: recipe.image ?? "",
                      width: 70,
                      height: 80,
                      fit: BoxFit.cover,

                      placeholder: (context, url) =>
                          Container(color: Colors.grey[200]),

                      errorWidget: (context, url, error) =>
                      const Icon(Icons.image_not_supported),
                    ),
                  ),

                  /// 📌 TITLE + RATING
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: const [
                          Icon(Icons.star,
                              color: Colors.orange, size: 14),
                          SizedBox(width: 4),
                          Text("4.5"),
                        ],
                      ),
                    ],
                  ),

                  /// 🔖 BOOKMARK
                  trailing: Icon(
                    Icons.bookmark_add,
                    color: AppColors.primary,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}