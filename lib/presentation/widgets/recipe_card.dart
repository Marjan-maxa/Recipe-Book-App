import 'package:flutter/material.dart';

import '../../domain/entities/recipe.dart';
import 'package:cached_network_image/cached_network_image.dart';
class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.recipe});
 final Recipe recipe;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: recipe.image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

        ],
      ),
    );
  }
}
