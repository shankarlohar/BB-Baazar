import 'package:bb_baazar/views/gallery/electronics_gallery_screen.dart';
import 'package:bb_baazar/views/gallery/men_gallery_screen.dart';
import 'package:bb_baazar/views/gallery/shoes_gallery_screen.dart';
import 'package:bb_baazar/views/gallery/women_gallery_screen.dart';
import 'package:bb_baazar/views/inner_screens/search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade100.withOpacity(0.5),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return SearchScreen();
              }));
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.6,
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(
                  25,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 30,
                  ),
                  Text(
                    "What are you looking for?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    height: 33,
                    width: 74,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Search",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          elevation: 0,
          bottom: TabBar(
            tabs: [
              RepeatedTab(
                title: "Men",
              ),
              RepeatedTab(
                title: "Women",
              ),
              RepeatedTab(
                title: "Electronics",
              ),
              RepeatedTab(
                title: "Shoes",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MenGalleryScreen(),
            WomenGalleryScreen(),
            ElectronicsGalleryScreen(),
            ShoesGalleryScreen(),
          ],
        ),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String title;
  const RepeatedTab({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        title,
        style: TextStyle(
          color: Colors.red.shade600,
        ),
      ),
    );
  }
}
