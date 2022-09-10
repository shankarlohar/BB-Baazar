import 'package:flutter/material.dart';

class UploadProductScreen extends StatefulWidget {
  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
// const UploadProductScreen({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.5,
                    color: Colors.blueGrey.shade100,
                    child: Center(
                      child: Text(
                        "You have not\n \nPicked any images ",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Category Here",
                  )
                ],
              ),
              SizedBox(
                height: 40,
                child: Divider(
                  color: Colors.cyan,
                  thickness: 1.4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.38,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Price",
                      hintText: "Price",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Quantity",
                      hintText: "Add Quantity",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    maxLength: 100,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: "Product Name",
                      hintText: "Enter Product Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    maxLength: 800,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: "Product Description",
                      hintText: "Enter Product Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.photo_library),
            ),
          ),
          FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.upload),
          ),
        ],
      ),
    );
  }
}
