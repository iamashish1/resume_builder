import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';
import 'package:resume_builder/features/home/template_model/template_model.dart';

import 'document_bulder_functions.dart';

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
    // final myResume = widget.resume;

    ResumeModel myResume = ResumeModel(
      id: 5,
      profile: Profile(
        title: "Software Engineer",
        name: "John Doe",
        position: "Software Engineer",
        phoneNumber: "123-456-7890",
        email: "john.doe@example.com",
        yourPortfolioSite: "",
        profileSummary:
            "Experienced software engineer with a passion for developing innovative solutions.",
      ),
      workExperience: [
        WorkExperience(
          designation: "Senior Software Engineer",
          companyName: "Tech Solutions Inc.",
          startDate: "2018-01-01",
          endDate: "2022-12-31",
          jobResponsibilities: [
            "Led a team of developers in the design and implementation of a new CRM system.",
            "Improved application performance by optimizing database queries.",
            "Collaborated with product managers to define project requirements and timelines.",
          ],
          isCurrentlyWorking: false,
        ),
        WorkExperience(
          designation: "Senior Software Engineer",
          companyName: "Tech Solutions Inc.",
          startDate: "2018-01-01",
          endDate: "2022-12-31",
          jobResponsibilities: [
            "Led a team of developers in the design and implementation of a new CRM system.",
            "Improved application performance by optimizing database queries.",
            "Collaborated with product managers to define project requirements and timelines.",
          ],
          isCurrentlyWorking: false,
        ),
          WorkExperience(
          designation: "Senior Software Engineer",
          companyName: "Tech Solutions Inc.",
          startDate: "2018-01-01",
          endDate: "2022-12-31",
          jobResponsibilities: [
            "Led a team of developers in the design and implementation of a new CRM system.",
            "Improved application performance by optimizing database queries.",
            "Collaborated with product managers to define project requirements and timelines.",
          ],
          isCurrentlyWorking: false,
        ),
        
      ],
      education: [
        Education(
          university: "University of Science and Technology",
          startDate: "2011-09-01",
          endDate: "2015-05-31",
          studyCourse: "Bachelor of Science in Computer Science",
          isCurrentlyStudying: false,
        ),
      ],
      skills: [
        "Communication Skills",
        "Interpersonal Skills",
        "Technical Skills",
     
      ],
    );

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

  final doc = pw.Document();

  // Register Montserrat font family
  final ttfRegular = pw.Font.ttf(regularFont);
  final ttfBold = pw.Font.ttf(boldFont);
  final ttfLight = pw.Font.ttf(lightFont);

  pw.RichText.debug = true;

  await buildPdf(doc, ttfRegular, ttfBold, ttfLight, resume);

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

class GreyHeading extends pw.StatelessWidget {
  String title;

  GreyHeading(this.title);
  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.circular(6),
            color: PdfColor.fromHex("#F1F1ED")),
        child: pw.Text(title.toUpperCase(),
            style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 13,
                letterSpacing: 3)));
  }
}
