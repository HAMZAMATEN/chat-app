import"package:flutter/material.dart";

import "../../res/colors/color.dart";
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    elevation: 0,
    centerTitle: true,
    title: Text("Search", style: TextStyle(color: Colors.white,
    fontSize: 27, fontWeight: FontWeight.bold),),
    backgroundColor: AppColors.primaryColor,
    ),
   body: Center(child:Text("Searchbar")),

    );
  }
}
