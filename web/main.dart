import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'product.dart';

Future<http.Response> fetchPhotos(http.Client client) async {
  return client.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
}

void main() {}

List<Product> parseProducts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

Future<List<Product>> fetchProducts() async {
  final response = await http.get('http://192.168.1.2:8000/products.json');
  if (response.statusCode == 200) {
    return parseProducts(response.body);
  } else {
    throw Exception('Unable to fetch products from the REST API');
  }
}
