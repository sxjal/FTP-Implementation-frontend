// // import 'dart:io';

// // import 'package:ftpconnect/ftpconnect.dart';

// // void main() async {
// //   final FTPConnect ftconnect = FTPConnect(
// //     "127.0.0.1:12356",
// //     user: "sxjal",
// //     pass: "12345",
// //     showLog: true,
// //   );
// //   Future<void> _log(String log) async {
// //     print(log);
// //     await Future.delayed(const Duration(seconds: 1));
// //   }

// //   await _log('Connecting to FTP ...');
// //   await ftconnect.connect();

// //   ///an auxiliary function that manage showed log to UI

// //   ///mock a file for the demonstration example
// //   Future<File> _fileMock({fileName = 'FlutterTest.txt', content = ''}) async {
// //     final Directory directory = Directory('/test')..createSync(recursive: true);
// //     final File file = File('${directory.path}/$fileName');
// //     await file.writeAsString(content);
// //     return file;
// //   }

// //   Future<void> _uploadStepByStep() async {
// //     try {
// //       await _log('Connecting to FTP ...');
// //       await ftconnect.connect();
// //       await ftconnect.changeDirectory('upload');
// //       File fileToUpload = await _fileMock(
// //           fileName: 'uploadStepByStep.txt', content: 'uploaded Step By Step');
// //       await _log('Uploading ...');
// //       await ftconnect.uploadFile(fileToUpload);
// //       await _log('file uploaded sucessfully');
// //       await ftconnect.disconnect();
// //     } catch (e) {
// //       await _log('Error: ${e.toString()}');
// //     }
// //   }

// //   Future<void> _uploadWithRetry() async {
// //     try {
// //       File fileToUpload = await _fileMock(
// //           fileName: 'uploadwithRetry.txt', content: 'uploaded with Retry');
// //       await _log('Uploading ...');
// //       await ftconnect.connect();
// //       await ftconnect.changeDirectory('upload');
// //       bool res =
// //           await ftconnect.uploadFileWithRetry(fileToUpload, pRetryCount: 2);
// //       await _log('file uploaded: ' + (res ? 'SUCCESSFULLY' : 'FAILED'));
// //       await ftconnect.disconnect();
// //     } catch (e) {
// //       await _log('Downloading FAILED: ${e.toString()}');
// //     }
// //   }

// //   Future<void> _downloadWithRetry() async {
// //     try {
// //       await _log('Downloading ...');

// //       String fileName = '../512KB.zip';
// //       await ftconnect.connect();
// //       //here we just prepare a file as a path for the downloaded file
// //       File downloadedFile = await _fileMock(fileName: 'downloadwithRetry.txt');
// //       bool res = await ftconnect.downloadFileWithRetry(fileName, downloadedFile,
// //           pRetryCount: 2);
// //       await _log('file downloaded  ' +
// //           (res ? 'path: ${downloadedFile.path}' : 'FAILED'));
// //       await ftconnect.disconnect();
// //     } catch (e) {
// //       await _log('Downloading FAILED: ${e.toString()}');
// //     }
// //   }

// //   Future<void> _downloadStepByStep() async {
// //     try {
// //       await _log('Connecting to FTP ...');

// //       await ftconnect.connect();

// //       await _log('Downloading ...');
// //       String fileName = '../512KB.zip';

// //       //here we just prepare a file as a path for the downloaded file
// //       File downloadedFile = await _fileMock(fileName: 'downloadStepByStep.txt');
// //       await ftconnect.downloadFile(fileName, downloadedFile);
// //       await _log('file downloaded path: ${downloadedFile.path}');
// //       await ftconnect.disconnect();
// //     } catch (e) {
// //       await _log('Downloading FAILED: ${e.toString()}');
// //     }
// //   }

// //   // await _uploadStepByStep();
// //   // await _uploadWithRetry();
// //   // await _downloadWithRetry();
// //   // await _downloadStepByStep();
// // }

// import 'dart:io';

// void main() async {
//   final socket = await Socket.connect(
//       '127.0.0.1', 12356); // Replace with your server's IP and port
//   print('Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');

//   // Sending data to the server
//   while (true) {
//     print("\n enter msg: ");
//     String? res = stdin.readLineSync();

//     socket.write(res);
//     print("msg sent");

//     // Listening for data from the server
//     socket.listen(
//       (data) {
//         print('Server: ${String.fromCharCodes(data)}');
//         print("pure data: $data");

//         if (data == "quit") {
//           socket.destroy();
//         }
//       },
//       onDone: () {
//         socket.destroy();
//       },
//       onError: (error) {
//         print('Error: $error');
//         socket.destroy();
//       },
//     );
//   }
// }

import 'dart:io';
import 'dart:async';

void main() async {
  final socket = await Socket.connect(
      '127.0.0.1', 12345); // Replace with your server's IP and port
  print('Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');

  // Create a Completer to signal when the response is received
  Completer<String> responseCompleter = Completer();

  // Listening for data from the server
  socket.listen(
    (data) {
      String response = String.fromCharCodes(data);
      responseCompleter.complete(response);
    },
    onError: (error) {
      print('Server error: $error');
      responseCompleter.completeError(error);
    },
    onDone: socket.close,
  );

  // Sending data to the server
  while (true) {
    socket.write('Hello, server!');
    String response = await responseCompleter.future;
    print('Received: $response');
    responseCompleter =
        Completer(); // Reset the completer for the next response
  }
}
