import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:game/AppModule/Guest/View/Guest.dart';
import 'package:game/Utils/AppStringConstants.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/custom_toast.dart';
import '../../leadScreen/View/lead.dart';
import '../HomeScreen/HomeScreen.dart';
import 'model/user_model.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _country = ''.obs;
  set setCountry(value) => _country.value = value;
  get getCountry => _country.value;

  signInValidation() {
    if (emailController.text.isEmpty && passwordController.text.isEmpty) {
      customSnackBar(title: "All Fields are required");
    } else if (emailController.text.isEmpty) {
      customSnackBar(title: 'Email is required');
    } else if (passwordController.text.isEmpty) {
      customSnackBar(title: 'Password is required');
    } else {
      if (!GetUtils.isEmail(emailController.text)) {
        customSnackBar(title: 'Email is not valid');
      } else {
        if (passwordController.text.length < 8) {
          customSnackBar(title: 'Password Should be minimum 8 letters');
        } else {
          signInWithEmailAndPassword();
        }
      }
    }
  }

  sigUpValidation() {
    if (nameController.text.isEmpty &&
        emailController.text.isEmpty &&
        phoneController.text.isEmpty &&
        passwordController.text.isEmpty &&
        confirmPassController.text.isEmpty) {
      customSnackBar(title: 'All Fields are required');
    } else if (nameController.text.isEmpty) {
      customSnackBar(title: 'Name is Required');
    } else if (emailController.text.isEmpty) {
      customSnackBar(title: 'Email is Required');
    } else if (phoneController.text.isEmpty) {
      customSnackBar(title: 'Phone Number is Required');
    } else if (passwordController.text.isEmpty) {
      customSnackBar(title: 'Password is Required');
    } else if (confirmPassController.text.isEmpty) {
      customSnackBar(title: 'Confirm Password is Required');
    } else {
      if (!GetUtils.isEmail(emailController.text)) {
        customSnackBar(title: 'Email is not valid');
      } else {
        if (passwordController.text.length < 8 &&
            confirmPassController.text.length < 8) {
          customSnackBar(
              title: 'Password & Confirm Password Should be minimum 8 letters');
        } else {
          if (passwordController.text != confirmPassController.text) {
            customSnackBar(
                title: 'Your password and confirm password should be same');
          } else {
            signUp();
          }
        }
      }
    }
  }

//////////signInWithEmailAndPassword
  Future<void> signInWithEmailAndPassword() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      isLoading(true);
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      getUserData();
      prefs.setBool(AppConstant.login, true);
      Get.offAll(() => GameScreen());

      isLoading(false);
      emailController.text = '';
      passwordController.text = '';
      print('User signed in: ${userCredential.user}');
    } catch (e) {
      // Handle sign-in errors.
      print('Failed to sign in: $e');
    }
  }

//////////////////Sign Up user with Email and password
  Future<bool> isEmailRegistered(String email) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      List<String> signInMethods = await auth.fetchSignInMethodsForEmail(email);

      // If signInMethods is not empty, it means the email is already registered
      return signInMethods.isNotEmpty;
    } catch (e) {
      debugPrint('Failed to check email registration: $e');
      // Show an error message or handle the error
      return false;
    }
  }

  Future<void> signUp() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (await isEmailRegistered(email)) {
      customSnackBar(title: 'Email is already registered!');
      // Show an error message or handle accordingly
    } else {
      try {
        await signUpWithEmailAndPassword(email, password);
        // Navigate to another screen or perform additional actions after successful sign-up
      } catch (e) {
        print('Failed to sign up: $e');
        // Show an error message or handle the error
      }
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // User successfully signed up
      User? user = userCredential.user;
      setUserData();
      print('Signed up: ${user!.uid}');
      isLoading(false);
      // Perform additional actions after successful sign-up
    } catch (e) {
      print('Failed to sign up: $e');
      // Show an error message or handle the error
    }
  }

  Future setUserData() async {
    try {
      isLoading(true);
      final prefs = await SharedPreferences.getInstance();
      print('Setting up user data');

      // String? token = await FirebaseMessaging.instance.getToken();

      //adding user detials
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'timestamp': DateTime.now().toString(),
        'user_name': nameController.text.toString(),
        'user_email': emailController.text.toString(),
        'phone': phoneController.text.toString(),
        'password': passwordController.text.toString(),
        'user_uid': FirebaseAuth.instance.currentUser!.uid,
        'country': getCountry,
      }).then((value) {
        prefs.setString(
            AppConstant.userUid, FirebaseAuth.instance.currentUser!.uid);
        prefs.setBool(AppConstant.login, true);
        nameController.text = '';
        emailController.text = '';
        phoneController.text = '';
        passwordController.text = '';
        confirmPassController.text = '';
        getUserData();
        Get.offAll(() => GameScreen());
        // Get.offAll(() => BottomNavigationScreen());
        isLoading(false);
      });
      isLoading(false);
    } catch (e) {
      // isLoading(false);
    } finally {
      // isLoading(false);
    }
  }

  /////////////////////////get UserData
  getUserData() async {
    try {
      isLoading(true);
      print('isLoading $isLoading');

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        UserModel user = UserModel(
          // firstName: value.data()!["timestamp"],
          name: value.data()!["user_name"],
          email: value.data()!["user_email"],
          phoneNumber: value.data()!["phone"],
          password: value.data()!["password"],
          uid: value.data()!["user_uid"],
          timestamp: value.data()!["timestamp"],
          country: value.data()!["country"],
        );
        // storageBox.write(StorageConstants.loggedInData, value.data());
        // print('data ${storageBox.read(StorageConstants.loggedInData)}');

        // Now, you can access user properties like this:
        // ...

        isLoading(false);
        update();
      });
    } catch (e) {
      print(e.toString());
      isLoading(false);
    }
  }

  Future<void> signOut() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await _auth.signOut();
      // Clear the user data or perform any other necessary actions.
      // For example, you can clear the shared preferences.
      // storageBox.erase();
      // storageBox.remove(StorageConstants.loggedInData);
      prefs.setBool(AppConstant.login, false);

      Get.offAll(() => GuestScreen());
      // Navigate to the login screen or any other screen after logout.
    } catch (e) {
      // Handle sign-out errors, if any.
      print('Failed to sign out: $e');
    }
  }
}
