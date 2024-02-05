import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';
import 'package:resume_builder/features/home/template_model/template_model.dart';

class ResumePreview extends StatefulWidget {
  final Template1Model resume;
  const ResumePreview({
    super.key,
    required this.resume,
  });

  @override
  State<ResumePreview> createState() => _ResumePreviewState();
}

class _ResumePreviewState extends State<ResumePreview> {
  @override
  Widget build(BuildContext context) {
    final myResume = widget.resume;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your CV Looks Amazing!'),
      ),
      body: PdfPreview(
        actionButtonBarColor: Colors.grey,
        canDebug: false,
        allowPrinting: false,
        canChangePageFormat: false,
        canChangeOrientation: false,
        // useActions: false,
        // maxPageWidth: 700,
        build: (format) async => generateResume(format, myResume),
        actions: const [
          PdfPreviewAction(
            icon: Icon(Icons.save),
            onPressed: _saveAsFile,
          )
        ],
      ),
    );
  }
}

Future<void> _saveAsFile(
  BuildContext context,
  LayoutCallback build,
  PdfPageFormat pageFormat,
) async {
  final bytes = await build(pageFormat);

  final appDocDir = await getApplicationDocumentsDirectory();
  final appDocPath = appDocDir.path;
  final file = File('$appDocPath/document.pdf');
  await file.writeAsBytes(bytes);
  await OpenFile.open(file.path);
}

Future<Uint8List> generateResume(format, Template1Model resume) async {
  final doc = pw.Document();

  doc.addPage(
    pw.MultiPage(
      build: (pw.Context context) => [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            pw.Align(
              child: pw.Text(resume.name ?? '',
                  textScaleFactor: 2,
                  textAlign: pw.TextAlign.center,
                  style: pw.Theme.of(context)
                      .defaultTextStyle
                      .copyWith(fontWeight: pw.FontWeight.bold)),
            ),
            pw.SizedBox(height: 10),
            pw.Align(
              child: pw.Text('Electrotyper',
                  textScaleFactor: 1.2,
                  style: pw.Theme.of(context).defaultTextStyle.copyWith(
                        fontWeight: pw.FontWeight.bold,
                      )),
            ),
            pw.SizedBox(height: 10),
            pw.Container(
              // color: PdfColor(1, 0, 0.3),
              width: double.infinity,
              child: pw.Wrap(
                alignment: pw.WrapAlignment.center,
                runAlignment: pw.WrapAlignment.center,
                // crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: <pw.Widget>[
                  pw.Text('${resume.phoneNumber}'),
                  pw.Text(" / "),
                  pw.Text('${resume.phoneNumber}'),
                  if (resume.yourPortfolioSite != "") ...[
                    pw.Text(" / "),
                    pw.Text('${resume.yourPortfolioSite}'),
                  ],
                ],
              ),
            ),
            pw.Divider(
                height: 20, thickness: 1, color: const PdfColor(0.5, 0.5, 0.5)),
            pw.Text('PROFILE:',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18)),
            pw.SizedBox(height: 4),
            pw.Text('${resume.profileSummary}'),
            pw.Divider(
                height: 35, thickness: 1, color: const PdfColor(0.5, 0.5, 0.5)),
            if (resume.workExperience?.isNotEmpty ?? false) ...[
              pw.Text('WORK EXPERIENCE:',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 18)),
              ...resume.workExperience?.map((e) {
                    return pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(height: 4),
                          pw.Text('${e.designation}'),
                          pw.SizedBox(height: 4),
                          pw.Text('${e.companyName}',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.SizedBox(height: 4),
                          pw.Text('${e.dateRange}'),
                          ...e.jobResponsibilities!.map((item) {
                            return pw.Padding(
                              padding:
                                  const pw.EdgeInsets.symmetric(vertical: 3.0),
                              child: BulletPoint(item: item),
                            );
                          }).toList(),
                          pw.SizedBox(height: 10)
                        ]);
                  }).toList() ??
                  [pw.SizedBox()]
            ],

            //START OF EDUCATION SECTION
            if (resume.education?.isNotEmpty ?? false) ...[
              pw.Text('EDUCATION:',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 18)),
              pw.SizedBox(height: 6),
              ...?resume.education?.map((e) {
                return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('${e.university}'),
                      pw.Text('${e.studyDateRange}'),
                      pw.Text('${e.studyCourse}'),
                    ]);
              }).toList()
            ],
            //END OF STUDY SECTION
            pw.SizedBox(height: 30),

            //START OF CERTIFICATION SECTION
            if (resume.certifications?.isNotEmpty ?? false) ...[
              pw.Text('CERTIFICATIONS:',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 18)),
              pw.SizedBox(height: 6),
              ...?resume.certifications?.map((e) {
                return BulletPoint(item: e);
              }).toList()
            ],
            pw.SizedBox(height: 30),

            //END OF CERTIFICATION SECTION

            //SKILLS SECTION START

            if (resume.certifications?.isNotEmpty ?? false) ...[
              pw.SizedBox(height: 6),
              pw.Text('SKILLS:',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 18)),
              pw.SizedBox(height: 6),
              ...?resume.skills?.map((e) {
                return BulletPoint(item: e);
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

  BulletPoint({required this.item});

  @override
  pw.Widget build(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Padding(
          padding: pw.EdgeInsets.only(
              top: 6.0, right: 8.0), // Reduce top padding to 0.0
          child: pw.Container(
            height: 8,
            width: 8,
            decoration: pw.BoxDecoration(
              color: PdfColor.fromInt(0x000000),
              shape: pw.BoxShape.circle,
            ),
          ),
        ),
        pw.Expanded(
          child: pw.Text(
            item,
            style: pw.TextStyle(fontSize: 16.0), // Adjust text style as needed
          ),
        ),
      ],
    );
  }
}
