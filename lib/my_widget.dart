// my_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'fetchdogimage.dart';

class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureDogImage = ref.watch(dogImageProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('犬の画像ランダム表示'),
      ),
      body: Center(
        child: futureDogImage.when(
          data: (url) => Image.network(
            url,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
          loading: () => CircularProgressIndicator(),
          error: (e, s) => Text('エラーが発生しました'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.refresh(dogImageProvider);
        },
        tooltip: '犬表示',
        child: const Icon(Icons.pets),
      ),
    );
  }
}
