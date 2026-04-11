import 'package:flutter/material.dart';
import 'package:recipebook/presentation/provider/recipe_provider.dart';
import 'package:provider/provider.dart';
import 'package:recipebook/presentation/screens/home_screen.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecipeProvider(),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
