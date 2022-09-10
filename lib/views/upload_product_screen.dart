import 'dart:ffi';
import 'dart:io';

import 'package:bb_baazar/controllers/snack_bar_controller.dart';
import 'package:bb_baazar/utilities/category_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class UploadProductScreen extends StatefulWidget {
  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
// const UploadProductScreen({ Key? key }) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String mainCategoryValue = "Select main category";
  String subCategoryValue = "Subcategory";

  List<String> subCategoryList = ["Subcategory"];

  late double price;
  late int quantity;
  late String productName;
  late String description;
  late String productId;

  List<XFile>? imageList = null;
  List<String> imageUrlList = [];

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

  Future<void> uploadImages() async {
    if (mainCategoryValue != "Select main category" &&
        subCategoryValue != "Subcategory") {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        if (imageList!.isNotEmpty) {
          try {
            for (var image in imageList!) {
              Reference ref = await firebaseStorage
                  .ref("products/${path.basename(image.path)}");
              await ref.putFile(File(image.path)).whenComplete(() async {
                await ref.getDownloadURL().then((value) {
                  imageUrlList.add(value);
                });
              });
            }
          } catch (e) {
            return snackBar("Something went wrong while uploading", context);
          }
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

  // "Men",
  // "Women",
  // "Electronics",
  // "Accessories",
  // "Shoes",
  // "Home & Garden",
  // "Beauty",
  // "Kids",
  // "Bags",

  void selectMainCategory(String? value) {
    if (value == "Men") {
      subCategoryList = men;
    } else if (value == "Women") {
      subCategoryList = women;
    } else if (value == "Electronics") {
      subCategoryList = electronics;
    } else if (value == "Accessories") {
      subCategoryList = accessories;
    } else if (value == "Home & Garden") {
      subCategoryList = homeandgarden;
    } else if (value == "Beauty") {
      subCategoryList = beauty;
    } else if (value == "Kids") {
      subCategoryList = kids;
    } else if (value == "Bags") {
      subCategoryList = bags;
    } else if (value == "Shoes") {
      subCategoryList = shoes;
    }

    setState(() {
      mainCategoryValue = value!;
      subCategoryValue = "Subcategory";
    });
  }

  void uploadData() async {
    if (imageUrlList.isNotEmpty) {
      CollectionReference productRef = firebaseFirestore.collection("products");
      productId = Uuid().v4();
      await productRef.doc(productId).set({
        "productId": productId,
        "mainCategory": mainCategoryValue,
        "subCategory": subCategoryValue,
        "price": price,
        "instock": quantity,
        "productName": productName,
        "productDescription": description,
        "sellerUid": FirebaseAuth.instance.currentUser!.uid,
        "productImages": imageUrlList,
        "discount": 0,
      }).whenComplete(() {
        setState(() {
          imageList = null;
          subCategoryList = ["Subcategory"];
          mainCategoryValue = "Select main category";
          subCategoryValue = "Subcategory";
          imageUrlList = [];
        });
        formKey.currentState!.reset();
      });
    }
  }

  void uploadProduct() async {
    await uploadImages().whenComplete(() => uploadData());
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
