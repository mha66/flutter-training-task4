import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task4/data/models/product_data.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../models/user_data.dart';
class DataSource
{
  static List<Product> productList = [];
  static List<Product> favouriteList = [];
  static bool isLoading = true;
  static bool isLoadingProfile = true;
  static UserDataModel? userData;

  static Future<void> getData() async{
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));
    if(response.statusCode == 200)
      {
        var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
        for(var item in jsonResponse['products'])
          {
            productList.add(Product.fromJson(item));
          }
      }
 }
  static Future<void> getDataFromFirebase() async{
    try{
      String? uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDocument = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userData = UserDataModel.fromJson(userDocument);
    } catch(error){
      print(error.toString());
    }
  }
}