import 'package:bb_baazar/views/categories/men_category_screen.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // const CategoryScreen({Key? key}) : super(key: key);
  final PageController pageController = PageController();
  List<ItemData> item = [
    ItemData(categoryName: "Men"),
    ItemData(categoryName: "Women"),
    ItemData(categoryName: "Shoes"),
    ItemData(categoryName: "Kids"),
    ItemData(categoryName: "Bags"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.2,
            child: ListView.builder(
              itemCount: item.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    pageController.jumpToPage(index);
                  },
                  child: Container(
                    color: item[index].isSelected
                        ? Colors.white
                        : Colors.grey.shade300,
                    height: 100,
                    child: Center(
                      child: Text(
                        item[index].categoryName,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.8,
            color: Colors.white,
            child: PageView(
              controller: pageController,
              onPageChanged: (value) {
                for (var ele in item) {
                  ele.isSelected = false;
                }
                setState(() {
                  item[value].isSelected = true;
                });
              },
              scrollDirection: Axis.vertical,
              children: [
                MenCategoryScreen(),
                Center(
                  child: Text(
                    "Women",
                  ),
                ),
                Center(
                  child: Text(
                    "Shoes",
                  ),
                ),
                Center(
                  child: Text(
                    "Kids",
                  ),
                ),
                Center(
                  child: Text(
                    "Bags",
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class ItemData {
  String categoryName;
  bool isSelected;

  ItemData({required this.categoryName, this.isSelected = false});
}
