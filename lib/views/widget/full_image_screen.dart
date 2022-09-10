import 'package:flutter/material.dart';

class FullImageScreen extends StatefulWidget {
  final List<dynamic> imageList;

  const FullImageScreen({super.key, required this.imageList});
  @override
  _FullImageScreenState createState() => _FullImageScreenState();
}

class _FullImageScreenState extends State<FullImageScreen> {
  final PageController pageController = PageController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              "${index + 1} / ${widget.imageList.length}",
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  index = value;
                });
              },
              controller: pageController,
              children: List.generate(widget.imageList.length, (index) {
                return Image.network(widget.imageList[index].toString());
              }),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    pageController.jumpToPage(index);
                  },
                  child: Image.network(
                    widget.imageList[index],
                  ),
                );
              },
              itemCount: widget.imageList.length,
            ),
          ),
        ],
      ),
    );
  }
}
