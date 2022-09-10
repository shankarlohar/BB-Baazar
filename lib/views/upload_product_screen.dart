import 'dart:ffi';
import 'dart:io';

import 'package:bb_baazar/controllers/snack_bar_controller.dart';
import 'package:bb_baazar/utilities/category_list.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadProductScreen extends StatefulWidget {
  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
// const UploadProductScreen({ Key? key }) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  String mainCategoryValue = "Select main category";
  String subCategoryValue = "Subcategory";

  List<String> subCategoryList = ["Subcategory"];

  late double price;
  late int quantity;
  late String productName;
  late String description;

  List<XFile>? imageList = null;

  void pickProductImages() async {
    try {
      final pickedImages = await picker.pickMultiImage(
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 100,
      );
      setState(() {
        imageList = pickedImages!;
      });
    } catch (e) {}
  }

  Widget displayImages() {
    return InkWell(
      onTap: () {
        setState(() {
          imageList = null;
        });
      },
      child: ListView.builder(
          itemCount: imageList!.length,
          itemBuilder: (context, index) {
            return Image.file(File(imageList![index].path));
          }),
    );
  }

  void uploadProduct() {
    if (mainCategoryValue != "Select main category" &&
        subCategoryValue != "Subcategory") {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        if (imageList!.isNotEmpty) {
          print(price);
          print(productName);
          setState(() {
            imageList = null;
          });
          formKey.currentState!.reset();
        } else {
          return snackBar("Please pick images", context);
        }
      } else {
        return snackBar("Fields must not be empty", context);
      }
    } else {
      return snackBar("Please select categories.", context);
    }
  }

  void selectMainCategory(String? value) {
    if (value == "Men") {
      subCategoryList = men;
    } else if (value == "Women") {
      subCategoryList = women;
    }

    setState(() {
      mainCategoryValue = value!;
      subCategoryValue = "Subcategory";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                        child: imageList != null
                            ? displayImages()
                            : Text(
                                "You have not\n \nPicked any images ",
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Select Main Category"),
                          DropdownButton(
                            borderRadius: BorderRadius.circular(
                              50,
                            ),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            value: mainCategoryValue,
                            items:
                                mainCategory.map<DropdownMenuItem<String>>((e) {
                              return DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              selectMainCategory(value);
                            },
                          ),
                          Text("Select Sub Category"),
                          DropdownButton(
                            value: subCategoryValue,
                            items: subCategoryList
                                .map<DropdownMenuItem<String>>((e) {
                              return DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                subCategoryValue = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
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
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Price must not be empty.";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Price",
                        hintText: "Price",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),
                      onSaved: (value) {
                        price = double.parse(value!);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Quatity must not be empty.";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Quantity",
                        hintText: "Add Quantity",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),
                      onSaved: (value) {
                        quantity = int.parse(value!);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Product name must not be empty.";
                        }
                      },
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
                      onSaved: (value) {
                        productName = value!;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Description must not be empty.";
                        }
                      },
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
                      onSaved: (value) {
                        description = value!;
                      },
                    ),
                  ),
                ),
              ],
            ),
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
              backgroundColor: Colors.red,
              onPressed: () {
                pickProductImages();
              },
              child: Icon(Icons.photo_library),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              uploadProduct();
            },
            child: Icon(Icons.upload),
          ),
        ],
      ),
    );
  }
}
