import 'package:flutter/material.dart';

import 'package:toastkit/toastkit.dart';
import 'package:toastkit/toastkit_platform_interface.dart';

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
                Toastkit.setStyle(mode: ToastMode.dark);
                Toastkit.setMaskMode(mode: ToastMaskMode.clear);
                Toastkit.setAnimationMode(mode: ToastAnimationMode.native);
              },
            ),
            IconButton(
              icon: const Icon(Icons.apple),
              onPressed: () {
                Toastkit.setStyle(mode: ToastMode.light);
                Toastkit.setMaskMode(mode: ToastMaskMode.black);
                Toastkit.setAnimationMode(mode: ToastAnimationMode.flat);
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
              },
            ),
            ListTile(
              title: const Text('Dismiss'),
              onTap: () {
                Toastkit.dismiss();
              },
            ),
            ListTile(
              title: const Text('Show Info With Text'),
              onTap: () {
                Toastkit.showInfoWithText("This is an info toast");
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
            ListTile(
              title: const Text('Dismiss Delay With Completion (2 seconds)'),
              onTap: () {
                Toastkit.dismissDelayWithCompletion(2000);
              },
            ),
          ],
        ),
      ),
    );
  }
}
