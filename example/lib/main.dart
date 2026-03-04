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
  @override
  void initState() {
    super.initState();
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
              onTap: () async{
                await Toastkit.dismiss();
                debugPrint("dismiss");
              },
            ),
            ListTile(
              title: const Text('showProgress'),
              onTap: () {
                Toastkit.showProgress(value: 0.5);
                // 延时2s消失
                Future.delayed(const Duration(seconds: 2), () {
                  Toastkit.dismiss();
                });
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
