import 'package:flutter/material.dart';

class SubCategoryScreen extends StatelessWidget {
  final String subCategoryName;
  final String mainCategory;

  const SubCategoryScreen(
      {super.key, required this.subCategoryName, required this.mainCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          subCategoryName,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Text(mainCategory),
      ),
    );
  }
}
