import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SocketIOExample(),
    );
  }
}

class SocketIOExample extends StatefulWidget {
  const SocketIOExample({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _SocketIOExampleState createState() => _SocketIOExampleState();
}

class _SocketIOExampleState extends State<SocketIOExample> {
  final String serverUrl = '127.0.0.1:1456';
  late io.Socket socket;
  TextEditingController messageController = TextEditingController();
  List<String> messages = [];

  @override
  void initState() {
    super.initState();

    // Initialize and connect to the socket server.
    socket = io.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();
  }

  // Function to send a message to the server.

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("data"),
      ),
    );
  }
}
