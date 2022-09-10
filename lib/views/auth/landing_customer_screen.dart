import 'package:bb_baazar/controllers/auth_controller.dart';
import 'package:bb_baazar/controllers/snack_bar_controller.dart';
import 'package:bb_baazar/views/auth/customer_login_screen.dart';
import 'package:bb_baazar/views/auth/landing_seller_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LandingCustomerScreen extends StatefulWidget {
  static const String routeName = "LandingCustomerScreen";
  @override
  State<LandingCustomerScreen> createState() => _LandingCustomerScreenState();
}

class _LandingCustomerScreenState extends State<LandingCustomerScreen> {
  // const LandingCustomerScreen({Key? key}) : super(key: key);
  final AuthController authController = AuthController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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

  signUp() async {
    setState(() {
      isLoading = true;
    });
    String res = await authController.signUpUsers(fullNameController.text,
        emailController.text, passwordController.text, image);
    setState(() {
      isLoading = false;
    });

    if (res != "Success") {
      return snackBar(res, context);
    } else {
      return Navigator.of(context).pushNamedAndRemoveUntil(
          CustomerLoginScreen.routeName, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Create Customer's Account",
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
                      controller: fullNameController,
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        hintText: "Enter Your Full Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            25,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Enter Your email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            25,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passwordController,
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return CustomerLoginScreen();
                            }));
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
                          "Create a seller's account",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, LandingSellerScreen.routeName);
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
    );
  }
}
