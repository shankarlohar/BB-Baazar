import 'package:bb_baazar/controllers/auth_controller.dart';
import 'package:bb_baazar/controllers/snack_bar_controller.dart';
import 'package:bb_baazar/views/auth/customer_login_screen.dart';
import 'package:bb_baazar/views/auth/landing_customer_screen.dart';
import 'package:bb_baazar/views/auth/seller_login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LandingSellerScreen extends StatefulWidget {
  static const String routeName = "LandingSellerScreen";
  @override
  State<LandingSellerScreen> createState() => _LandingSellerScreenState();
}

class _LandingSellerScreenState extends State<LandingSellerScreen> {
  // const LandingSellerScreen({Key? key}) : super(key: key);
  final AuthController authController = AuthController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  late String fullName;
  late String email;
  late String password;

  bool passwordVisible = true;
  bool isLoading = false;

  Uint8List? image;

  pickImageFromGallery() async {
    Uint8List? im = await authController.pickImage(ImageSource.gallery);
    setState(() {
      image = im;
    });
  }

  pickImageFromCamera() async {
    Uint8List im = await authController.pickImage(ImageSource.camera);
    setState(() {
      image = im;
    });
  }

  uploadImageToStorage(Uint8List? image) async {
    Reference ref = firebaseStorage
        .ref()
        .child("profiles")
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void signUp() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (formKey.currentState!.validate()) {
        if (image != null) {
          await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password);

          String downloadUrl = await uploadImageToStorage(image);

          await firestore
              .collection("Sellers")
              .doc(firebaseAuth.currentUser!.uid)
              .set({
            "SellerUid": firebaseAuth.currentUser!.uid,
            "storeName": fullName,
            "email": email,
            "password": password,
            "address": '',
            "image": downloadUrl,
          }).whenComplete(
            () => setState(
              () {
                isLoading = false;
              },
            ),
          );

          formKey.currentState!.reset();
          setState(() {
            image = null;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          return snackBar("Image is required", context);
        }
      } else {
        setState(() {
          isLoading = false;
        });
        return snackBar("Please fields should not be empty.", context);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      return snackBar(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Create a sellers's account",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.person,
                          size: 35,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      image != null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.red,
                              backgroundImage: MemoryImage(image!),
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.red,
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                pickImageFromCamera();
                              },
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                pickImageFromGallery();
                              },
                              icon: Icon(
                                Icons.photo,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Full name must not be empty.";
                          } else {
                            null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Shop Name",
                          hintText: "Enter Your Shop Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              25,
                            ),
                          ),
                        ),
                        onChanged: (String value) {
                          fullName = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email must not be empty.";
                          } else {
                            null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Enter Your email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              25,
                            ),
                          ),
                        ),
                        onChanged: (String value) {
                          email = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password must not be empty.";
                          } else {
                            null;
                          }
                        },
                        obscureText: passwordVisible,
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "Enter Your Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                            icon: passwordVisible
                                ? Icon(
                                    Icons.visibility,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                  ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              25,
                            ),
                          ),
                        ),
                        onChanged: (String value) {
                          password = value;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          signUp();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                          ),
                          child: Center(
                            child: isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, SellerLoginScreen.routeName);
                            },
                            child: Text(
                              "Login",
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Or",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Create customer's account",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, LandingCustomerScreen.routeName);
                            },
                            child: Text(
                              "Sign Up",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
