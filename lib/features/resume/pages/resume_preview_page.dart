import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';
import 'package:resume_builder/features/home/template_model/template_model.dart';

class ResumePreview extends StatefulWidget {
  final ResumeModel resume;
  const ResumePreview({
    super.key,
    required this.resume,
  });

  @override
  State<ResumePreview> createState() => _ResumePreviewState();
}

class _ResumePreviewState extends State<ResumePreview> {
  TextEditingController name = TextEditingController();
  Future<void> _saveAsFile(
    BuildContext context,
    LayoutCallback build,
    PdfPageFormat pageFormat,
  ) async {
    final bytes = await build(pageFormat);

    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    String documentName = name.text.isEmpty ? "document" : name.text;
    final file = File('$appDocPath/$documentName.pdf');
    if (await file.exists() && mounted) {
      // If the file exists, prompt the user to decide
      final action = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('File Already Exists'),
          content: const Text(
              'A file named "document.pdf" already exists. Do you want to overwrite it or create a copy?'),
          actions: [
            TextButton(
              onPressed: () {
                return Navigator.pop(context, 'overwrite');
              },
              child: const Text('Overwrite'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'copy'),
              child: const Text('Create Copy'),
            ),
          ],
        ),
      );

      // Based on user action, handle file saving
      if (action == 'overwrite') {
        await file.writeAsBytes(bytes);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Overwrite successful')));
        }
        // await OpenFile.open(file.path);
      } else if (action == 'copy') {
        // Generate a new file name by adding a timestamp to it
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final newFileName = '${documentName}_$timestamp.pdf';
        final newFile = File('$appDocPath/$newFileName');

        // Write bytes to the new file
        await newFile.writeAsBytes(bytes);
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Copy successful')));
        }

        // await OpenFile.open(newFile.path);
      }
    } else {
      await file.writeAsBytes(bytes);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Download successful. Check downloads page')));
      }
      // await OpenFile.open(file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final myResume = widget.resume;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: TextField(
            controller: name,
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: "document.pdf(Default)"),
          )),
      body: PdfPreview(
        actionButtonBarColor: Colors.grey,
        canDebug: false,
        allowPrinting: false,
        canChangePageFormat: false,
        canChangeOrientation: false,
        // useActions: false,
        // maxPageWidth: 700,
        build: (format) async => generateResume(format, myResume),
        actions: [
          PdfPreviewAction(
            icon: const Icon(Icons.save),
            onPressed: _saveAsFile,
          )
        ],
      ),
    );
  }
}

Future<Uint8List> generateResume(format, ResumeModel resume) async {
  // Load Montserrat font files
  final regularFont =
      await rootBundle.load('assets/font/Montserrat-Regular.ttf');
  final boldFont = await rootBundle.load('assets/font/Montserrat-Bold.ttf');
  final lightFont = await rootBundle.load('assets/font/Montserrat-Light.ttf');
  final italic = await rootBundle.load('assets/font/Montserrat-Italic.ttf');

  final doc = pw.Document();

  // Register Montserrat font family
  final ttfRegular = pw.Font.ttf(regularFont);
  final ttfBold = pw.Font.ttf(boldFont);
  final ttfLight = pw.Font.ttf(lightFont);
  final ttfItalic = pw.Font.ttf(lightFont);

  pw.RichText.debug = true;

  doc.addPage(
    pw.MultiPage(
      theme: pw.ThemeData(
          defaultTextStyle: pw.TextStyle(
              letterSpacing: 0.5,
              wordSpacing: 2,
              lineSpacing: 5,
              font: ttfRegular,
              fontBold: ttfBold,
              fontNormal: ttfRegular)),
      build: (pw.Context context) => [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            pw.Align(
              child: pw.Text(resume.profile.name.toUpperCase(),
                  textScaleFactor: 2,
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, letterSpacing: 6)),
            ),
            pw.SizedBox(height: 10),
            pw.Align(
              child: pw.Text(resume.profile.title,
                  textScaleFactor: 1.2,
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, letterSpacing: 3)),
            ),
            pw.SizedBox(height: 20),
            pw.Container(
              // color: PdfColor(1, 0, 0.3),
              width: double.infinity,
              child: pw.Wrap(
                alignment: pw.WrapAlignment.center,
                runAlignment: pw.WrapAlignment.center,
                // crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: <pw.Widget>[
                  pw.Text('${resume.profile?.phoneNumber}'),
                  pw.Text(" / "),
                  pw.Text('${resume.profile?.email}'),
                  if (resume.profile?.yourPortfolioSite != "") ...[
                    pw.Text(" / "),
                    pw.Text('${resume.profile?.yourPortfolioSite}'),
                  ],
                ],
              ),
            ),
            pw.Divider(
                height: 60, thickness: 1, color: const PdfColor(0.5, 0.5, 0.5)),
            Heading("Profile"),
            pw.SizedBox(height: 8),
            BodyText(resume.profile.profileSummary, ttfLight),
            pw.Divider(
                height: 60, thickness: 1, color: const PdfColor(0.5, 0.5, 0.5)),
            if (resume.workExperience?.isNotEmpty ?? false) ...[
              Heading("Work Experience"),
              ...resume.workExperience?.map((e) {
                    return pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(height: 4),
                          pw.Text(e.designation.toUpperCase(),
                              style:
                                  pw.TextStyle(font: ttfRegular, fontSize: 10)),
                          pw.SizedBox(height: 7),
                          pw.Text(e.companyName,
                              style: pw.TextStyle(
                                  letterSpacing: 2,
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10)),
                          pw.SizedBox(height: 10),
                          pw.Text('${e.startDate} - ${e.endDate}'),
                          ...e.jobResponsibilities.map((item) {
                            return pw.Padding(
                              padding:
                                  const pw.EdgeInsets.symmetric(vertical: 3.0),
                              child: BulletPoint(item: item, font: ttfLight),
                            );
                          }).toList(),
                          pw.SizedBox(height: 10)
                        ]);
                  }).toList() ??
                  [pw.SizedBox()]
            ],
            if (resume.education.isNotEmpty ||
                resume.certifications.isNotEmpty ||
                resume.skills.isNotEmpty)
              pw.Divider(
                  height: 10,
                  thickness: 1,
                  color: const PdfColor(0.5, 0.5, 0.5)),
            pw.SizedBox(height: 10),
            //START OF EDUCATION SECTION
            if (resume.education?.isNotEmpty ?? false) ...[
              Heading("Education"),
              ...?resume.education?.map((e) {
                return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(e.university,
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 4),
                      BodyText("${e.startDate} - ${e.endDate}", ttfLight),
                      pw.SizedBox(height: 3),
                      BodyText(e.studyCourse, ttfLight),
                    ]);
              }).toList()
            ],
            //END OF STUDY SECTION
            pw.SizedBox(height: 20),

            //START OF CERTIFICATION SECTION
            if (resume.certifications.isNotEmpty) ...[
              Heading("Certifications"),
              pw.SizedBox(height: 6),
              ...?resume.certifications?.map((e) {
                return BulletPoint(item: e, font: ttfLight);
              }).toList()
            ],
            if (resume.certifications.isNotEmpty) pw.SizedBox(height: 30),

            //END OF CERTIFICATION SECTION

            //SKILLS SECTION START

            if (resume.skills.isNotEmpty) ...[
              pw.SizedBox(height: 6),
              Heading("skills"),
              pw.SizedBox(height: 6),
              ...resume.skills.map((e) {
                return BulletPoint(item: e, font: ttfLight);
              }).toList()
            ]

            //SKILLS SECTION END
          ],
        ),
      ],
    ),
  );
  return doc.save();
}

class BulletPoint extends pw.StatelessWidget {
  final String item;
  pw.Font font;

  BulletPoint({required this.item, required this.font});

  @override
  pw.Widget build(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 4.0, right: 5.0),
          child: pw.Container(
            height: 4,
            width: 4,
            decoration: const pw.BoxDecoration(
              color: PdfColor.fromInt(0x000000),
              shape: pw.BoxShape.circle,
            ),
          ),
        ),
        pw.Expanded(
          child: BodyText(item, font),
        ),
      ],
    );
  }
}

class Heading extends pw.StatelessWidget {
  String title;

  Heading(this.title);
  @override
  pw.Widget build(pw.Context context) {
    return pw.Text(title.toUpperCase(),
        style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold, fontSize: 13, letterSpacing: 3));
  }
}

class BodyText extends pw.StatelessWidget {
  String text;
  pw.Font font;
  BodyText(this.text, this.font);
  @override
  pw.Widget build(pw.Context context) {
    return pw.Text(text,
        style: pw.TextStyle(
            fontSize: 10,
            font: font,
            letterSpacing: 0.5,
            wordSpacing: 2,
            lineSpacing: 5));
  }
}
