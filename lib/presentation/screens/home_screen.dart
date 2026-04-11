import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:recipebook/core/app_strings.dart';
import 'package:recipebook/presentation/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> categories = [
    'All',
    'Italian',
    'Chinese',
    'Mexican',
    'Indian',
    'French',
    'Japanese',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text('Recipe Book'),
            Text('Welcome Back'),
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),

              child: CachedNetworkImage(imageUrl: AppStrings.profileImageUrl)),
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
          }, icon: Icon(Icons.search)),
          IconButton(onPressed: (){
          }, icon: Icon(Icons.notifications)),

        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Category',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,

              ),)
            ],
          ),
        ),
      ),


    );
  }
}


// 1:02 after start