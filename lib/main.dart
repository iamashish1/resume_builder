import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:resume_builder/features/authentication/presentation/pages/signin_page.dart';
import 'package:resume_builder/features/home/downloads_page.dart';
import 'package:resume_builder/features/home/home_view.dart';
import 'package:resume_builder/features/home/homepage.dart';
import 'package:resume_builder/features/resume/resume_preview_page.dart';
import 'package:resume_builder/firebase_options.dart';

import 'core/app_exceptions/app_exceptions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Homepage(),
    );
  }
}


// class MyResumePage extends StatelessWidget {
//   const MyResumePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Resume'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Your Name',
//               style: Theme.of(context).textTheme.headline6,
//             ),
//             Text('Your Address', style: Theme.of(context).textTheme.bodyText2),
//             Text('Your Phone', style: Theme.of(context).textTheme.bodyText2),
//             Text('Your Email', style: Theme.of(context).textTheme.bodyText2),
//             // Add more sections as needed
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async => createPDF(),
//         child: const Icon(Icons.download),
//       ),
//     );
//   }

//   Future<Uint8List?> createPDF() async {
//     final pdf = pw.Document();

//     List headers = [
//       "Property",
//       "Value",
//     ];

//     pdf.addPage(
//       pw.MultiPage(
//         build: (context) => [
//           pw.SizedBox(height: 100),
//           pw.Text(
//             "Dart is awesome",
//             style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//           ),
//           pw.Text(
//             "Hello World",
//             style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//           ),
//           pw.SizedBox(height: 100),
//           // pw.TableHelper.fromTextArray(
//           //     data: data,
//           //     headers: headers,
//           //     tableWidth: pw.TableWidth.max,
//           //     border: pw.TableBorder.all(color: PdfColors.black, width: 1.0))
//         ],
//       ),
//     );

//     List<int> bytes = await pdf.save();
//     saveAndLaunchFile(bytes, 'PDF Document.pdf');
//     return pdf.save();
//   }

//   Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
//     bool dirDownloadExists = true;
//     String androidDirectory;
//     androidDirectory = '/storage/emulated/0/Download/';

//     dirDownloadExists = await Directory(androidDirectory).exists();

//     if (dirDownloadExists) {
//       androidDirectory = "/storage/emulated/0/Download";
//     } else {
//       androidDirectory = "/storage/emulated/0/Downloads";
//     }

//     final path = Platform.isAndroid
//         ? androidDirectory
//         : (await getApplicationDocumentsDirectory()).path;

//     final file = File('$path/$fileName');
//     await file.writeAsBytes(bytes, flush: true);
//     OpenFile.open('$path/$fileName');
//   }
// }


// //There is permission denied error at first launch of the app
