import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> fetchDogImage() async {
  try {
    final response =
        await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    } else {
      throw Exception('Failed to load dog image');
    }
  } catch (e) {
    print('画像取得失敗 $e');
    throw Exception('エラーが発生しました');
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '犬の画像ランダム表示',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '犬の画像ランダム表示'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<String> futureDogImage;
  @override
  void initState() {
    super.initState();
    futureDogImage = fetchDogImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: futureDogImage,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Image.network(
                snapshot.data!,
                fit: BoxFit.cover, // or BoxFit.fill depending on your needs
                width: MediaQuery.of(context).size.width,
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            futureDogImage = fetchDogImage();
          });
        },
        tooltip: '犬表示',
        child: const Icon(Icons.pets),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
