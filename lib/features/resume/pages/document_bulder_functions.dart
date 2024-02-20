import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:resume_builder/features/home/template_model/template_model.dart';
import 'package:resume_builder/features/resume/pages/resume_preview_page.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

Future<void> buildPdf(pw.Document doc, pw.Font ttfRegular, pw.Font ttfBold,
    pw.Font ttfLight, ResumeModel resume) async {
  if (resume.id == 1) {
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
                  height: 60,
                  thickness: 1,
                  color: const PdfColor(0.5, 0.5, 0.5)),
              Heading("Profile"),
              pw.SizedBox(height: 8),
              BodyText(resume.profile.profileSummary, ttfLight),
              pw.Divider(
                  height: 60,
                  thickness: 1,
                  color: const PdfColor(0.5, 0.5, 0.5)),
              if (resume.workExperience?.isNotEmpty ?? false) ...[
                Heading("Work Experience"),
                ...resume.workExperience?.map((e) {
                      return pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.SizedBox(height: 4),
                            pw.Text(e.designation.toUpperCase(),
                                style: pw.TextStyle(
                                    font: ttfRegular, fontSize: 10)),
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
                                padding: const pw.EdgeInsets.symmetric(
                                    vertical: 3.0),
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
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
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
  } else if (resume.id == 2) {
// Assuming 'phone_icon.png' is the name of your icon file in the assets folder
    final ByteData phoneData =
        await rootBundle.load('assets/icons/phone-call.png');
    final ByteData globeData = await rootBundle.load('assets/icons/global.png');

    final ByteData emailData = await rootBundle.load('assets/icons/email.png');

    final phoneBytes = phoneData.buffer.asUint8List();
    final emailBytes = emailData.buffer.asUint8List();
    final globeBytes = globeData.buffer.asUint8List();

    final phoneIcon = pw.MemoryImage(phoneBytes);
    final emailIcon = pw.MemoryImage(emailBytes);

    final globeIcon = pw.MemoryImage(globeBytes);

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
              pw.Container(
                width: 300,
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration:
                    pw.BoxDecoration(color: PdfColor.fromHex("#F1F1ED")),
                child: pw.Text(resume.profile.name.toUpperCase(),
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.start,
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, letterSpacing: 6)),
              ),
              pw.SizedBox(height: 10),
              pw.Padding(
                padding: const pw.EdgeInsets.only(left: 20),
                child: pw.Text(resume.profile.title,
                    textScaleFactor: 1.2,
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, letterSpacing: 3)),
              ),
              pw.SizedBox(height: 70),
              pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                          Heading("Contact"),
                          pw.SizedBox(height: 15),
                          pw.Row(
                            children: [
                              pw.Image(phoneIcon, height: 15, width: 15),
                              pw.SizedBox(width: 15),
                              pw.Flexible(
                                child: pw.Text(
                                  resume.profile.phoneNumber,
                                ),
                              )
                            ],
                          ),
                          pw.SizedBox(height: 10),
                          pw.Row(
                            children: [
                              pw.Image(emailIcon, height: 15, width: 15),
                              pw.SizedBox(width: 15),
                              pw.Flexible(
                                child: pw.Text(
                                  resume.profile.email,
                                ),
                              )
                            ],
                          ),
                          pw.SizedBox(height: 10),
                          pw.Row(
                            children: [
                              pw.Image(globeIcon, height: 15, width: 15),
                              pw.SizedBox(width: 15),
                              pw.Flexible(
                                child: pw.Text(
                                  resume.profile.yourPortfolioSite,
                                ),
                              )
                            ],
                          ),
                        ])),
                    //START OF EDUCATION SECTION
                    if (resume.education?.isNotEmpty ?? false) ...[
                      pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                        Heading("Education"),
                        pw.SizedBox(height: 10),
                        ...?resume.education?.map((e) {
                          return pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(e.university,
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold)),
                                pw.SizedBox(height: 10),
                                BodyText(
                                    "${e.startDate} - ${e.endDate}", ttfLight),
                                pw.SizedBox(height: 10),
                                BodyText(e.studyCourse, ttfLight),
                              ]);
                        }).toList()
                      ])),
                    ],
                    //END OF STUDY SECTION
                  ])
            ],
          ),
        ],
      ),
    );
  } else if (resume.id == 3) {
  } else if (resume.id == 4) {
  } else if (resume.id == 5) {}
}
