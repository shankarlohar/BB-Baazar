import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  // FUNCTION TO PICK IMAGE FROM GALLERY OR CAMERA
  // FUNCTION TO UPLOAD PICKED IMAGE TO STORAGE
  uploadImageToStorage(Uint8List? image) async {
    Reference ref =
        firebaseStorage.ref().child("profiles").child(auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(source: source);

    if (file != null) {
      return file.readAsBytes();
    } else {
      print("No Image Selected.");
    }
  }

  Future<String> signUpUsers(
      String fullName, String email, String password, Uint8List? image) async {
    String res = "some error occured";
    try {
      if (fullName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential cred = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String downloadUrl = await uploadImageToStorage(image);

        await firestore.collection('customers').doc(cred.user!.uid).set({
          "cid": cred.user!.uid,
          "fullName": fullName,
          "email": email,
          "image": downloadUrl,
          "address": '',
        });

        res = "Success";
        print("Account Created!");
      } else {
        res = "Fields should not be empty!";
        print("Account Not Created! Fields Empty.");
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUsers(String email, String password) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        res = "Success";
        print("Logged in successfully!");
      } else {
        res = "Please fill in the email and password.";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
