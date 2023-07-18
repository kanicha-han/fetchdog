import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

Future<String> fetchDogImage() async {
  final response =
      await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
  return jsonDecode(response.body)['message'] as String;
}

//プロバイダ
final dogImageProvider = FutureProvider<String>((ref) async {
  return await fetchDogImage();
});
