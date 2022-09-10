import 'package:bb_baazar/views/minor_screens/sub_category_screen.dart';
import 'package:flutter/material.dart';

import '../../utilities/category_list.dart';

class MenCategoryScreen extends StatefulWidget {
  @override
  State<MenCategoryScreen> createState() => _MenCategoryScreenState();
}

class _MenCategoryScreenState extends State<MenCategoryScreen> {
// const MenCategoryScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(
            "Men",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.68,
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 70,
            children: List.generate(
              men.length - 1,
              (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SubCategoryScreen(
                              subCategoryName: men[index + 1],
                              mainCategory: "Men",
                            );
                          },
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.asset(
                            "assets/images/men/men$index.jpg",
                          ),
                        ),
                        Text(
                          men[index + 1],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
