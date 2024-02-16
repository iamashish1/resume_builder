import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:path/path.dart' as path;

class DownloadedPDFsPage extends StatefulWidget {
  @override
  _DownloadedPDFsPageState createState() => _DownloadedPDFsPageState();
}

class _DownloadedPDFsPageState extends State<DownloadedPDFsPage> {
  List<FileSystemEntity> pdfFiles = [];

  @override
  void initState() {
    super.initState();
    loadPDFs();
  }

  Future<void> loadPDFs() async {
    final dir = await getApplicationDocumentsDirectory();
    final files = Directory(dir.path).listSync();
    pdfFiles = files.where((file) => file.path.contains('.pdf')).toList();
    setState(() {}); // Trigger a rebuild to update the UI
  }
    final dateFormat = DateFormat("MMMM d, yyyy");


  @override
  Widget build(BuildContext context) {
    return pdfFiles.isNotEmpty
        ? ListView.builder(
            itemCount: pdfFiles.length,
            itemBuilder: (context, index) {
              final file = File(pdfFiles[index].path);
              final lastModified = file.lastModifiedSync();
              return ListTile(
                leading: Image.asset("assets/pdf_icon.png"),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("File Name: ${path.basename(pdfFiles[index].path)}"),
                    Text("Last Modifified: ${dateFormat.format(lastModified)}")
                  ],
                ),
                onTap: () async {
                  // final file = File("pdfFiles[index].path");
                  await OpenFile.open(pdfFiles[index].path);

                  // Open the PDF file using your preferred PDF viewer
                  // You can use a package like 'flutter_pdfview' for this purpose
                  // Example: https://pub.dev/packages/flutter_pdfview
                  print('Opening PDF: ${pdfFiles[index].path}');
                },
              );
            },
          )
        : Center(
            child: Text('No PDFs downloaded yet.'),
          );
  }
}
