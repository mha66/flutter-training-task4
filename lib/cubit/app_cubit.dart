import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../data/models/product_data.dart';
import '../data/models/user_data.dart';

part 'app_state.dart';

class AppCubitA extends Cubit<AppStateA> {
  AppCubitA() : super(AppInitial());

  List<Product> productList = [];
  List<Product> favouriteList = [];
  UserDataModel? userData;

  Future<void> getData() async {
    try {
      emit(ProductsLoadingState());
      final response =
          await http.get(Uri.parse('https://dummyjson.com/products'));
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        for (var item in jsonResponse['products']) {
          productList.add(Product.fromJson(item));
        }
        emit(ProductsDoneState());
      }
    } catch (error) {
      emit(ProductsErrorState());
    }
  }

  Future<void> getDataFromFirebase() async {
    try {
      emit(UserDataLoadingState());
      String? uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDocument =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userData = UserDataModel.fromJson(userDocument);
      emit(UserDataDoneState());
    } catch (error) {
      emit(UserDataErrorState(error.toString()));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      emit(LoginLoadingState());
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        if (value.user != null) {
          emit(LoginDoneState());
          await getDataFromFirebase();
        }
      });
    } catch (error) {
      emit(LoginErrorState(error.toString()));
    }
  }

  Future<bool> saveUserData({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String uid,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
        'uid': uid,
        'image': '',
      }, SetOptions(merge: true));
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      emit(SignupLoadingState());
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        if (value.user != null) {
          await saveUserData(
                  name: name,
                  email: email,
                  password: password,
                  phone: phone,
                  uid: value.user!.uid)
              .then((value) async {
            if (value) {
              emit(SignupDoneState());
              await getDataFromFirebase();
            } else {
              emit(SignupErrorState('Error in saving data'));
            }
          });
        }
      });
    } catch (error) {
      emit(SignupErrorState(error.toString()));
    }
  }

  Future<bool> signOut() async {
    try {
      emit(SignOutLoadingState());
      await FirebaseAuth.instance.signOut();
      emit(SignOutDoneState());
      return true;
    } catch (error) {
      emit(SignOutErrorState(error.toString()));
      return false;
    }
  }

  void togglePasswordVisibility() {
    if (state is PasswordVisible) {
      emit(PasswordObscured());
    } else {
      emit(PasswordVisible());
    }
  }

  int currentPageIndex = 0;

  void getPage(int index) {
    currentPageIndex = index;
    emit(NewPage());
  }

  int sum = 0;

  void getSum(int x, int y) {
    sum = x + y;
    emit(GetSum());
  }

  ImagePicker picker = ImagePicker();
  File? img;

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      img = File(image.path);
      uploadImageToFirebaseStorage(img!);
    }
  }

  Future<void> uploadImageToFirebaseStorage(File image) async {
    try {
      emit(UploadImageLoadingState());
      String uid = FirebaseAuth.instance.currentUser!.uid;

      final ref = FirebaseStorage.instance.ref().child('usersImages').child('${DateTime.now()}.jpg');
      await ref.putFile(image);
      String? url = await ref.getDownloadURL();
      userData!.image = url;
      await FirebaseFirestore.instance.collection('users').doc(uid).update({'image': url});
      emit(UploadImageDoneState());
    } catch (e) {
      emit(UploadImageErrorState(e.toString()));
    }
  }
}
