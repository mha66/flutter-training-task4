import 'package:task4/data/models/product_data.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
class DataSource
{
  static List<Product> productList = [];
  static bool isLoading = true;

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

}