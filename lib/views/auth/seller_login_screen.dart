import 'package:bb_baazar/controllers/auth_controller.dart';
import 'package:bb_baazar/controllers/snack_bar_controller.dart';
import 'package:bb_baazar/views/auth/landing_customer_screen.dart';
import 'package:bb_baazar/views/customer_home_screen.dart';
import 'package:bb_baazar/views/seller_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SellerLoginScreen extends StatefulWidget {
  static const String routeName = "SellerLoginScreen";
  @override
  State<SellerLoginScreen> createState() => _SellerLoginScreenState();
}

class _SellerLoginScreenState extends State<SellerLoginScreen> {
  // const SellerLoginScreen({Key? key}) : super(key: key);
  final FirebaseAuth auth = FirebaseAuth.instance;
  final AuthController authController = AuthController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool passwordVisible = true;
  bool isLoading = false;

  late String email, password;

  loginSeller() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (formkey.currentState!.validate()) {
        await auth
            .signInWithEmailAndPassword(email: email, password: password)
            .whenComplete(() {
          setState(() {
            isLoading = false;
          });
        });
        return Navigator.of(context).pushNamedAndRemoveUntil(
            SellerHomeScreen.routeName, (route) => false);
      } else {
        setState(() {
          isLoading = false;
        });
        return snackBar("Fields are empty.", context);
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
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sign in to Seller's account",
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
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email must not be empty.";
                          } else {
                            return null;
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
                        onChanged: (value) {
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
                            return null;
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
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          loginSeller();
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
                                    "Log in",
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
                            "Don't have an account?",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return LandingCustomerScreen();
                              }));
                            },
                            child: Text(
                              "Sign up",
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
                            "Create a seller's account",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
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
