import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:ftpconnect/ftpConnect.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  void connect() async {
    final FTPConnect _ftpConnect = FTPConnect(
      "http://127.0.0.1/12356",
      user: "sxjal",
      pass: "12345",
      showLog: true,
    );

    
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Center"),
      ),
    );
  }
}
