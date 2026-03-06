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
      (v) => Toastkit.showProgress(value: v),
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
                Toastkit.init(
                  mode: ToastMode.dark,
                  maskMode: ToastMaskMode.black,
                  animationMode: ToastAnimationMode.native,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.apple),
              onPressed: () {
                Toastkit.init(
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
                Toastkit.show();
                // 延时2s消失
                Future.delayed(const Duration(seconds: 2), () {
                  Toastkit.dismiss();
                });
              },
            ),
            ListTile(
              title: const Text('Dismiss'),
              onTap: () async {
                _progressSubscription?.cancel();
                _progressSubscription = null;
                await Toastkit.dismiss();
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
                await Toastkit.showText("Show Text");
                debugPrint("Info toast displayed");
              },
            ),
            ListTile(
              title: const Text('Show Success With Text'),
              onTap: () {
                Toastkit.showSuccessWithText("This is a success toast");
              },
            ),
            ListTile(
              title: const Text('Show Warning With Text'),
              onTap: () {
                Toastkit.showWarningWithText("This is a warning toast");
              },
            ),
            ListTile(
              title: const Text('Show Error With Text'),
              onTap: () {
                Toastkit.showErrorWithText("This is an error toast");
              },
            ),
          ],
        ),
      ),
    );
  }
}
