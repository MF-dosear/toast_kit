import 'dart:async';

import 'package:flutter/material.dart';

import 'package:toastkit/toastkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<double>? _progressSubscription;

  @override
  void dispose() {
    _progressSubscription?.cancel();
    super.dispose();
  }

  void _startProgressStream() {
    _progressSubscription?.cancel();
    const step = 0.05;
    const interval = Duration(milliseconds: 500);
    var value = 0.0;
    _progressSubscription = Stream.periodic(interval, (_) {
      value = (value + step).clamp(0.0, 1.0);
      return value;
    }).take(21).listen(
      (v) {
        if (v >= 1.0) {
          Toast.dismiss();
        } else {
          Toast.showProgress(value: v);
        }
      },
      onDone: () => _progressSubscription = null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
          backgroundColor: Colors.blueAccent,
          actions: [
            IconButton(
              icon: const Icon(Icons.android_rounded),
              onPressed: () {
                Toast.setStyle(
                  mode: ToastMode.dark,
                  maskMode: ToastMaskMode.black,
                  animationMode: ToastAnimationMode.native,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.apple),
              onPressed: () {
                Toast.setStyle(
                  mode: ToastMode.light,
                  maskMode: ToastMaskMode.gradient,
                  animationMode: ToastAnimationMode.flat,
                );
              },
            ),
          ],
        ),
        body: ListView(
          children: [
            ListTile(
              title: const Text('Show'),
              onTap: () {
                Toast.show();
                // 延时2s消失
                Future.delayed(const Duration(seconds: 2), () {
                  Toast.dismiss();
                });
              },
            ),
            ListTile(
              title: const Text('Dismiss'),
              onTap: () async {
                _progressSubscription?.cancel();
                _progressSubscription = null;
                await Toast.dismiss();
                debugPrint("dismiss");
              },
            ),
            ListTile(
              title: const Text('showProgress'),
              subtitle: const Text('每 0.5s 更新，进度缓慢 0→1'),
              onTap: () {
                _startProgressStream();
              },
            ),
            ListTile(
              title: const Text('Show Text'),
              onTap: () async {
                await Toast.showText("Show Text");
                debugPrint("Info toast displayed");
              },
            ),
            ListTile(
              title: const Text('Show Success'),
              onTap: () {
                Toast.showSuccess("This is a success toast");
              },
            ),
            ListTile(
              title: const Text('Show Info'),
              onTap: () {
                Toast.showInfo("This is a warning toast");
              },
            ),
            ListTile(
              title: const Text('Show Error'),
              onTap: () {
                Toast.showError("This is an error toast");
              },
            ),
          ],
        ),
      ),
    );
  }
}
