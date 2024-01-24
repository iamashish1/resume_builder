import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DownloadedPDFsPage extends StatefulWidget {
  @override
  _DownloadedPDFsPageState createState() => _DownloadedPDFsPageState();
}

class _DownloadedPDFsPageState extends State<DownloadedPDFsPage> {
   List<FileSystemEntity> pdfFiles=[];

  @override
  void initState() {
    super.initState();
    loadPDFs();
  }

  Future<void> loadPDFs() async {
    final dir = await getApplicationDocumentsDirectory();
    final files = Directory(dir.path).listSync();
    pdfFiles = files.where((file) => file.path.contains('')).toList();
    setState(() {}); // Trigger a rebuild to update the UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Downloaded PDFs'),
      ),
      body: pdfFiles.isNotEmpty
          ? ListView.builder(
              itemCount: pdfFiles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Opening PDF: ${pdfFiles[index].path}'),
                  onTap: () {
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
            ),
    );
  }
}
