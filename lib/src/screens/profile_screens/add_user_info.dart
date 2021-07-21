import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realcallerapp/models/basicuser.dart';
import 'package:realcallerapp/src/screens/blank_page.dart';
import 'package:realcallerapp/src/screens/home.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';
import 'package:realcallerapp/repositories/firebase_repository/firebase_storage_repo.dart';
import 'package:realcallerapp/repositories/phone_auth_repository.dart';
import 'package:realcallerapp/repositories/firebase_repository/firestore_repo.dart';

class AddUserInfo extends StatefulWidget {
  _AddUserInfoState createState() => _AddUserInfoState();
}

class _AddUserInfoState extends State<AddUserInfo> {
  TextEditingController _firstnameTextEditingController =
      TextEditingController();
  TextEditingController _lastnameTextEditingController =
      TextEditingController();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  TextEditingController _websiteTextEditingController = TextEditingController();
  TextEditingController _addressTextEditingController = TextEditingController();
  FirebaseStorageRepo _firebaseStorageRepo = FirebaseStorageRepo();
  PhoneAuthRepository _phoneAuthRepository = PhoneAuthRepository();
  FirestoreRepo _firestoreRepo = FirestoreRepo();
  bool isAddUserInfoActive = false;
  bool isPasswordSeen = false;

  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  checkIfAddUserInfoIsActive() {
    if (_firstnameTextEditingController.text != "" &&
        _emailTextEditingController.text != "" &&
        _passwordEditingController.text.length > 8) {
      setState(() {
        isAddUserInfoActive = true;
      });
    }
  }

  createMyProfile({required BuildContext context}) async {
    String imageUrl;
    String userID = _phoneAuthRepository.getLoggedInUserID();
    if (_image != null) {
      imageUrl = await _firebaseStorageRepo.uploadProfileImage(
          file: _image!, userID: userID);
    } else {
      imageUrl = "";
    }
    // try {
    // UserCredential userCredentialCreate =
    //     await _firestoreRepo.createAccountWithEmail(
    //         _emailTextEditingController.text, _passwordEditingController.text);
    // await _firestoreRepo.signInAccountWithEmail(
    //     _emailTextEditingController.text, _passwordEditingController.text);
    AuthCredential authCredential = _firestoreRepo.getEmailAuthCredential(
        _emailTextEditingController.text, _passwordEditingController.text);
    if (authCredential != null) {
      User user = _firestoreRepo.getCurrentUser()!;
      user.linkWithCredential(authCredential);
    } else {
      print("Auth Credential = null");
    }

    // } catch (e) {}
    BasicUser basicUser = BasicUser(
        userID: userID,
        firstname: _firstnameTextEditingController.text,
        lastname: _lastnameTextEditingController.text,
        email: _emailTextEditingController.text,
        phone: _phoneAuthRepository.getLoggedInUserPhoneNumber(),
        // website: _websiteTextEditingController.text,
        // address: _addressTextEditingController.text,
        profileUrl: imageUrl);
    bool isProfileCreationCompleted =
        await _firestoreRepo.addUserToDb(basicUser);
    if (isProfileCreationCompleted) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return Home();
      }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Profile Creation Failed!"),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
          width: 100,
          height: 40,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/images/logos/logo_realcaller_purple.png"))),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 32,
                ),
                InkWell(
                  onTap: () {
                    getImage();
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Container(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: _image == null
                              ? AssetImage("assets/images/no_image.png")
                              : FileImage(_image!) as ImageProvider,
                        ),
                        Positioned(
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: CustomColors.greyDark,
                                      offset: Offset(1, 1),
                                      spreadRadius: 1,
                                      blurRadius: 10)
                                ],
                                color: CustomColors.purpleLight,
                                borderRadius: BorderRadius.circular(25)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.camera,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          bottom: 0,
                          right: 0,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 42,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xfff1f1f1),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    onChanged: (value) {
                      checkIfAddUserInfoIsActive();
                    },
                    keyboardType: TextInputType.text,
                    controller: _firstnameTextEditingController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Firstname"),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xfff1f1f1),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    onChanged: (value) {
                      checkIfAddUserInfoIsActive();
                    },
                    keyboardType: TextInputType.text,
                    controller: _lastnameTextEditingController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Lastname"),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xfff1f1f1),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    onChanged: (value) {
                      checkIfAddUserInfoIsActive();
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTextEditingController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Email"),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xfff1f1f1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            checkIfAddUserInfoIsActive();
                          },
                          keyboardType: TextInputType.text,
                          controller: _passwordEditingController,
                          obscureText: !isPasswordSeen,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: "Password"),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      IconButton(
                          icon: Icon((isPasswordSeen)
                              ? EvaIcons.eye
                              : EvaIcons.eyeOff),
                          onPressed: () {
                            setState(() {
                              isPasswordSeen = !isPasswordSeen;
                            });
                          })
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 14),
                //   height: 50,
                //   decoration: BoxDecoration(
                //       color: Color(0xfff1f1f1),
                //       borderRadius: BorderRadius.circular(10)),
                //   child: TextField(
                //     keyboardType: TextInputType.url,
                //     controller: _websiteTextEditingController,
                //     decoration: InputDecoration(
                //         border: InputBorder.none, hintText: "Website"),
                //     style: TextStyle(fontSize: 16),
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 14),
                //   height: 50,
                //   decoration: BoxDecoration(
                //       color: Color(0xfff1f1f1),
                //       borderRadius: BorderRadius.circular(10)),
                //   child: TextField(
                //     keyboardType: TextInputType.streetAddress,
                //     controller: _addressTextEditingController,
                //     decoration: InputDecoration(
                //         border: InputBorder.none, hintText: "Address"),
                //     style: TextStyle(fontSize: 16),
                //   ),
                // ),
                SizedBox(
                  height: 32,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  padding: EdgeInsets.all(6),
                  color: (isAddUserInfoActive)
                      ? CustomColors.accentPurpleDark
                      : CustomColors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                  onPressed: () {
                    if (isAddUserInfoActive) {
                      createMyProfile(context: context);
                    }
                  },
                  child: Text(
                    "Create My Profile",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
