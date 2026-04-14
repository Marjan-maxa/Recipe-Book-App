import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../domain/entities/recipe.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../screens/recipe_details_screen.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.recipe});
  final Recipe recipe;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>RecipeDetailsScreen(id: recipe.id)));
        },
        child: Container(
          padding: .all(6),
          clipBehavior: .none,
          child: Column(
            spacing: 6,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),

                    child: CachedNetworkImage(
                      imageUrl: recipe.image,
                      height: 170,
                      width: double.infinity,

                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      height: 37,
                      width: 65,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.customOverlay,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: .min,
                        children: [
                          Icon(Icons.star, color: AppColors.starColor, size: 20),
                          SizedBox(width: 4),
                          Text(
                            '4.5',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color:Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 170,
                child: Text(
                  recipe.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
