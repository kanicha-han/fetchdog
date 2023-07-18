import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

@riverpod
Future<String> fetchDogImage() async {
  final respons =
      await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
  return jsonDecode(respons.body)['message'];
}

//プロバイダ
final dogImageProvider = FutureProvider<String>((ref) async {
  return await fetchDogImage();
});
