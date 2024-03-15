import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:resume_builder/core/theme/app_colors.dart';

class DownloadedPDFsPage extends StatefulWidget {
  const DownloadedPDFsPage({super.key});

  @override
  _DownloadedPDFsPageState createState() => _DownloadedPDFsPageState();
}

class _DownloadedPDFsPageState extends State<DownloadedPDFsPage> {
  List<FileSystemEntity> pdfFiles = [];

  Future<void> deleteFile(int index) async {
    final file = File(pdfFiles[index].path);
    try {
      await file.delete();
      setState(() {
        pdfFiles.removeAt(index);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Document Successfully Deleted!')));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error deleting item!')));
      }
    }
  }

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
        ? ListView.separated(
            padding: const EdgeInsets.all(10),
            separatorBuilder: (_, __) => const Gap(15),
            itemCount: pdfFiles.length,
            itemBuilder: (context, index) {
              final file = File(pdfFiles[index].path);
              final lastModified = file.lastModifiedSync();
              return ListTile(
                tileColor: index % 2 == 0
                    ? Colors.green[50]?.withOpacity(0.5)
                    : Colors.amber[50]?.withOpacity(0.5),
                leading: Image.asset("assets/pdf_icon.png"),
                trailing: IconButton(
                  onPressed: () async {
                    final action = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete'),
                        content: const Text('Do you wish to delete the file?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              return Navigator.pop(context, true);
                            },
                            child: const Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                    );
                    if (action == true) {
                      await deleteFile(index);
                    }
                  },
                  icon: const Icon(
                    Icons.delete_sweep_outlined,
                    color: AppColors.primaryGreen,
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "File Name: ${path.basename(pdfFiles[index].path)}",
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Last Modifified: ${dateFormat.format(lastModified)}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.black45),
                    )
                  ],
                ),
                onTap: () async {
                  final res =
                      await OpenFile.open(pdfFiles[index].path );
                  if (res.type == ResultType.fileNotFound) {
                    Fluttertoast.showToast(msg: 'File Not Found');
                  }


                },
              );
            },
          )
        : const Center(
            child: Text('No PDFs downloaded yet.'),
          );
  }
}
