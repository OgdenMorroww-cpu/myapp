// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final globalKey = GlobalKey<ScaffoldState>();
    const String fileName = "myAppNote.txt";
    Future<void> _exportToFile(BuildContext context) async {
      final File file = File("${Directory.current.absolute.path}/$fileName");
      final snackBar = SnackBar(content: Text("Saved: ${file.path}"));

      await file.writeAsString(textController.text);
      // ignore: deprecated_member_use
      globalKey.currentState!.showSnackBar(snackBar);
    }

    return MaterialApp(
      title: "MyApp",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        key: globalKey,
        appBar: AppBar(
          title: Text("MyApp"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            color: Colors.white,
            icon: Icon(Icons.menu),
          ),
        ),
        body: Center(
          child: TextField(
            controller: textController,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            expands: true,
            decoration: InputDecoration(
              hintText: "Paste or type your notes here",
              contentPadding: EdgeInsets.all(12.0),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _exportToFile(context);
          },
          tooltip: "Export to $fileName",
          backgroundColor: Colors.red,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
