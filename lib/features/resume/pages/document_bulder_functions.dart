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
                width: double.infinity,
                child: pw.Wrap(
                  alignment: pw.WrapAlignment.center,
                  runAlignment: pw.WrapAlignment.center,
                  children: <pw.Widget>[
                    pw.Text(resume.profile.phoneNumber),
                    pw.Text(" / "),
                    pw.Text(resume.profile.email),
                    if (resume.profile.yourPortfolioSite != "") ...[
                      pw.Text(" / "),
                      pw.Text(resume.profile.yourPortfolioSite),
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
              if (resume.workExperience.isNotEmpty) ...[
                Heading("Work Experience"),
                ...resume.workExperience.map((e) {
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
                }).toList()
              ],
              if (resume.education.isNotEmpty || resume.skills.isNotEmpty)
                pw.Divider(
                    height: 10,
                    thickness: 1,
                    color: const PdfColor(0.5, 0.5, 0.5)),
              pw.SizedBox(height: 10),
              //START OF EDUCATION SECTION
              if (resume.education.isNotEmpty) ...[
                Heading("Education"),
                ...resume.education.map((e) {
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
                font: ttfRegular, fontBold: ttfBold, fontNormal: ttfRegular)),
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
                          if (resume.profile.yourPortfolioSite != "")
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
                    if (resume.education.isNotEmpty) ...[
                      pw.Expanded(
                          child: pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 20),
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              Heading("Education"),
                              pw.SizedBox(height: 10),
                              ...resume.education.map((e) {
                                return pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(e.university,
                                          style: pw.TextStyle(
                                              fontWeight: pw.FontWeight.bold)),
                                      pw.SizedBox(height: 10),
                                      BodyText("${e.startDate} - ${e.endDate}",
                                          ttfLight),
                                      pw.SizedBox(height: 10),
                                      BodyText(e.studyCourse, ttfLight),
                                    ]);
                              }).toList()
                            ]),
                      )),
                    ],
                    //END OF STUDY SECTION
                  ]),
              pw.SizedBox(height: 50),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                      child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      //SUMMARY
                      Heading("Summary"),
                      pw.SizedBox(height: 12),
                      BodyText(resume.profile.profileSummary, ttfLight),
                      //END SUMMARY
                      pw.SizedBox(height: 20),

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
                  )),
                  if (resume.workExperience.isNotEmpty)
                    pw.Expanded(
                        child: pw.Padding(
                            padding: const pw.EdgeInsets.only(left: 20),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                Heading("Work Experience"),
                                pw.SizedBox(height: 10),
                                ...resume.workExperience.map((e) {
                                  return pw.Stack(
                                      fit: pw.StackFit.loose,
                                      overflow: pw.Overflow.visible,
                                      children: [
                                        pw.Container(
                                            padding: const pw.EdgeInsets.only(
                                                left: 10),
                                            decoration: pw.BoxDecoration(
                                                border: pw.Border(
                                                    left: pw.BorderSide(
                                                        color: PdfColor.fromHex(
                                                            "#000000"),
                                                        width: 2))),
                                            child: pw.Column(
                                                crossAxisAlignment:
                                                    pw.CrossAxisAlignment.start,
                                                children: [
                                                  pw.SizedBox(height: 4),
                                                  pw.Text(e.companyName,
                                                      style: pw.TextStyle(
                                                          letterSpacing: 2,
                                                          fontWeight: pw
                                                              .FontWeight.bold,
                                                          fontSize: 10)),
                                                  pw.SizedBox(height: 7),
                                                  pw.Text(e.designation,
                                                      style: pw.TextStyle(
                                                          font: ttfRegular,
                                                          fontSize: 10)),
                                                  pw.SizedBox(height: 10),
                                                  pw.Text(
                                                      '${e.startDate} - ${e.endDate}'),
                                                  ...e.jobResponsibilities
                                                      .map((item) {
                                                    return pw.Padding(
                                                      padding: const pw
                                                          .EdgeInsets.symmetric(
                                                          vertical: 3.0),
                                                      child: BulletPoint(
                                                          item: item,
                                                          font: ttfLight),
                                                    );
                                                  }).toList(),
                                                  pw.SizedBox(height: 10)
                                                ])),
                                        pw.Positioned(
                                            left: -4,
                                            top: 6,
                                            child: pw.Container(
                                                width: 8,
                                                height: 8,
                                                decoration: pw.BoxDecoration(
                                                    color: PdfColor.fromHex(
                                                        "#000000"),
                                                    shape: pw.BoxShape.circle)))
                                      ]);
                                }).toList()
                              ],
                            )))
                ],
              )
            ],
          ),
        ],
      ),
    );
  } else if (resume.id == 3) {
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
                font: ttfRegular, fontBold: ttfBold, fontNormal: ttfRegular)),
        build: (pw.Context context) => [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: <pw.Widget>[
              pw.Text(resume.profile.name.toUpperCase(),
                  textScaleFactor: 2,
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, letterSpacing: 6)),
              pw.SizedBox(height: 10),
              pw.Padding(
                padding: const pw.EdgeInsets.only(left: 0),
                child: pw.Text(resume.profile.title,
                    textScaleFactor: 1.2,
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, letterSpacing: 3)),
              ),
              pw.SizedBox(height: 30),
              pw.Divider(color: PdfColor.fromHex("#000000"), thickness: 3),
              pw.SizedBox(height: 10),
              pw.Row(children: [
                pw.Expanded(
                  flex: 3,
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        //Contact Section START
                        pw.Container(
                          padding: const pw.EdgeInsets.only(
                              left: 10, right: 30, top: 20, bottom: 20),
                          decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.circular(6),
                              color: PdfColor.fromHex("#F1F1ED")),
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              mainAxisSize: pw.MainAxisSize.min,
                              children: [
                                Heading("Contact"),
                                pw.SizedBox(height: 20),
                                pw.Row(
                                  mainAxisSize: pw.MainAxisSize.min,
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
                                  mainAxisSize: pw.MainAxisSize.min,
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
                                if (resume.profile.yourPortfolioSite != "")
                                  pw.Row(
                                    mainAxisSize: pw.MainAxisSize.min,
                                    children: [
                                      pw.Image(globeIcon,
                                          height: 15, width: 15),
                                      pw.SizedBox(width: 15),
                                      pw.Flexible(
                                        child: pw.Text(
                                          resume.profile.yourPortfolioSite,
                                        ),
                                      )
                                    ],
                                  ),
                              ]),
                        ),

                        //Contact Section END
                        //SUMMARY
                        pw.SizedBox(height: 30),

                        GreyHeading("Profile"),
                        pw.SizedBox(height: 12),
                        BodyText(resume.profile.profileSummary, ttfLight),
                        //END SUMMARY
                        //START OF EDUCATION SECTION
                        if (resume.education.isNotEmpty) ...[
                          pw.SizedBox(height: 30),
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                Heading("Education"),
                                pw.SizedBox(height: 10),
                                ...resume.education.map((e) {
                                  return pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(e.university,
                                            style: pw.TextStyle(
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                        pw.SizedBox(height: 10),
                                        BodyText(
                                            "${e.startDate} - ${e.endDate}",
                                            ttfLight),
                                        pw.SizedBox(height: 10),
                                        BodyText(e.studyCourse, ttfLight),
                                      ]);
                                }).toList()
                              ]),
                        ],
                      ]),
                ),
                pw.Expanded(
                    flex: 4,
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          //WORK EXP SECTION START
                          if (resume.workExperience.isNotEmpty)
                            pw.Padding(
                                padding: const pw.EdgeInsets.only(left: 20),
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    GreyHeading("Work Experience"),
                                    pw.SizedBox(height: 10),
                                    ...resume.workExperience.map((e) {
                                      return pw.Stack(
                                          fit: pw.StackFit.loose,
                                          overflow: pw.Overflow.visible,
                                          children: [
                                            pw.Container(
                                                padding:
                                                    const pw.EdgeInsets.only(
                                                        left: 10),
                                                decoration: pw.BoxDecoration(
                                                    border: pw.Border(
                                                        left: pw.BorderSide(
                                                            color: PdfColor
                                                                .fromHex(
                                                                    "#000000"),
                                                            width: 2))),
                                                child: pw.Column(
                                                    crossAxisAlignment: pw
                                                        .CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      pw.SizedBox(height: 4),
                                                      pw.Text(e.companyName,
                                                          style: pw.TextStyle(
                                                              letterSpacing: 2,
                                                              fontWeight: pw
                                                                  .FontWeight
                                                                  .bold,
                                                              fontSize: 10)),
                                                      pw.SizedBox(height: 7),
                                                      pw.Text(e.designation,
                                                          style: pw.TextStyle(
                                                              font: ttfRegular,
                                                              fontSize: 10)),
                                                      pw.SizedBox(height: 10),
                                                      pw.Text(
                                                          '${e.startDate} - ${e.endDate}'),
                                                      ...e.jobResponsibilities
                                                          .map((item) {
                                                        return pw.Padding(
                                                          padding: const pw
                                                              .EdgeInsets.symmetric(
                                                              vertical: 3.0),
                                                          child: BulletPoint(
                                                              item: item,
                                                              font: ttfLight),
                                                        );
                                                      }).toList(),
                                                      pw.SizedBox(height: 10)
                                                    ])),
                                            pw.Positioned(
                                                left: -4,
                                                top: 6,
                                                child: pw.Container(
                                                    width: 8,
                                                    height: 8,
                                                    decoration:
                                                        pw.BoxDecoration(
                                                            color: PdfColor
                                                                .fromHex(
                                                                    "#000000"),
                                                            shape: pw.BoxShape
                                                                .circle)))
                                          ]);
                                    }).toList()
                                  ],
                                ))

                          //WORK EXP SECTION END
                        ]))
              ]),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                      child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      //SKILLS SECTION START

                      if (resume.skills.isNotEmpty) ...[
                        pw.SizedBox(height: 20),
                        GreyHeading("Skills"),
                        pw.SizedBox(height: 6),
                        ...resume.skills.map((e) {
                          return BulletPoint(item: e, font: ttfLight);
                        }).toList()
                      ]

                      //SKILLS SECTION END
                    ],
                  )),
                ],
              )
            ],
          ),
        ],
      ),
    );
  } else if (resume.id == 4) {
    doc.addPage(
      pw.MultiPage(
        theme: pw.ThemeData(
          defaultTextStyle: pw.TextStyle(
            letterSpacing: 0.5,
            wordSpacing: 2,
            lineSpacing: 5,
            font: ttfRegular,
            fontBold: ttfBold,
            fontNormal: ttfRegular,
          ),
        ),
        build: (pw.Context context) => [
          pw.Container(
            padding:
                const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Text(
                  resume.profile.name.toUpperCase(),
                  textScaleFactor: 2,
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  resume.profile.title,
                  textScaleFactor: 1.2,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                pw.SizedBox(height: 10),
                BodyText(resume.profile.profileSummary, ttfLight),
                pw.Divider(height: 30, thickness: 1, color: PdfColors.grey),
                _CustomHeading("Contact Information"),
                pw.SizedBox(height: 8),
                pw.Text("Phone: ${resume.profile.phoneNumber}"),
                pw.Text("Email: ${resume.profile.email}"),
                if (resume.profile.yourPortfolioSite != "")
                  pw.Text("Portfolio: ${resume.profile.yourPortfolioSite}"),
                pw.Divider(height: 30, thickness: 1, color: PdfColors.grey),
                _CustomHeading("Work Experience"),
                pw.SizedBox(height: 8),
                for (var experience in resume.workExperience)
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "${experience.designation} at ${experience.companyName}",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 14,
                          color: PdfColors.blue,
                        ),
                      ),
                      pw.Text(
                          "${experience.startDate} - ${experience.endDate}"),
                      for (var responsibility in experience.jobResponsibilities)
                        pw.Text("• $responsibility"),
                      pw.SizedBox(height: 10),
                    ],
                  ),
                pw.Divider(height: 30, thickness: 1, color: PdfColors.grey),
                _CustomHeading("Education"),
                pw.SizedBox(height: 8),
                for (var education in resume.education)
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        education.university,
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 14,
                          color: PdfColors.blue,
                        ),
                      ),
                      pw.Text("${education.startDate} - ${education.endDate}"),
                      pw.Text(education.studyCourse),
                      pw.SizedBox(height: 10),
                    ],
                  ),
                pw.Divider(height: 30, thickness: 1, color: PdfColors.grey),
                _CustomHeading("Skills"),
                pw.SizedBox(height: 8),
                for (var skill in resume.skills) pw.Text("• $skill"),
              ],
            ),
          ),
        ],
      ),
    );
  } else if (resume.id == 5) {
    doc.addPage(
      pw.Page(
          margin: pw.EdgeInsets.zero,
          theme: pw.ThemeData(
            defaultTextStyle: pw.TextStyle(
              font: pw.Font.ttf(
                  await rootBundle.load("assets/font/Manrope-Regular.ttf")),
              color: PdfColors.black,
              fontSize: 12,
            ),
          ),
          build: (pw.Context context) => pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                        margin: const pw.EdgeInsets.all(8),
                        width: 200,
                        color: PdfColor.fromHex("#323B4C"),
                        child: pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text("Contact".toUpperCase(),
                                            style: pw.TextStyle(
                                                color: PdfColors.white,
                                                fontWeight: pw.FontWeight.bold,
                                                fontSize: 16,
                                                letterSpacing: 2)),
                                        pw.Divider(
                                            color: PdfColor.fromHex("#ffffff"),
                                            thickness: 3),
                                        pw.SizedBox(height: 15),
                                        pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text('Phone',
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                  color: PdfColors.white,
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                )),
                                            pw.SizedBox(width: 2),
                                            pw.Text(resume.profile.phoneNumber,
                                                style: pw.TextStyle(
                                                    color: PdfColors.white))
                                          ],
                                        ),
                                        pw.SizedBox(height: 10),
                                        pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text('Email',
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                  color: PdfColors.white,
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                )),
                                            pw.SizedBox(width: 2),
                                            pw.Text(resume.profile.email,
                                                style: pw.TextStyle(
                                                    color: PdfColors.white))
                                          ],
                                        ),
                                        pw.SizedBox(height: 10),
                                        pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text('Your Site',
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                  color: PdfColors.white,
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                )),
                                            pw.SizedBox(width: 2),
                                            if (resume.profile
                                                    .yourPortfolioSite !=
                                                "")
                                              pw.Text(
                                                  resume.profile
                                                      .yourPortfolioSite,
                                                  style: pw.TextStyle(
                                                      color: PdfColors.white))
                                          ],
                                        ),
                                      ]),
                                  pw.SizedBox(height: 15),
                                  pw.Text("Education".toUpperCase(),
                                      style: pw.TextStyle(
                                          color: PdfColors.white,
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 16,
                                          letterSpacing: 2)),
                                  pw.Divider(
                                      color: PdfColor.fromHex("#ffffff"),
                                      thickness: 3),
                                  pw.SizedBox(height: 15),
                                  ...resume.education.map((e) {
                                    return pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Text(e.university,
                                              style: pw.TextStyle(
                                                fontSize: 13,
                                                color: PdfColors.white,
                                                fontWeight: pw.FontWeight.bold,
                                              )),
                                          pw.SizedBox(height: 10),
                                          pw.Text(
                                              "${e.startDate} - ${e.endDate}",
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  font: ttfRegular,
                                                  letterSpacing: 0.5,
                                                  color: PdfColors.white,
                                                  wordSpacing: 2,
                                                  lineSpacing: 5)),
                                          pw.SizedBox(height: 10),
                                          pw.Text(e.studyCourse,
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  font: ttfRegular,
                                                  color: PdfColors.white,
                                                  letterSpacing: 0.5,
                                                  wordSpacing: 2,
                                                  lineSpacing: 5)),
                                        ]);
                                  }).toList(),
                                  pw.SizedBox(height: 15),
                                  pw.Text("Skills".toUpperCase(),
                                      style: pw.TextStyle(
                                          color: PdfColors.white,
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 16,
                                          letterSpacing: 2)),
                                  pw.Divider(
                                      color: PdfColor.fromHex("#ffffff"),
                                      thickness: 3),
                                  pw.SizedBox(height: 15),
                                  pw.SizedBox(height: 6),
                                  ...resume.skills.map((e) {
                                    return pw.Row(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Padding(
                                          padding: const pw.EdgeInsets.only(
                                              top: 4.0, right: 5.0),
                                          child: pw.Container(
                                            height: 4,
                                            width: 4,
                                            decoration: pw.BoxDecoration(
                                              color:
                                                  PdfColor.fromHex("#ffffff"),
                                              shape: pw.BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        pw.Expanded(
                                            child: pw.Text(e,
                                                style: pw.TextStyle(
                                                    fontSize: 10,
                                                    font: ttfRegular,
                                                    color: PdfColors.white,
                                                    letterSpacing: 0.5,
                                                    wordSpacing: 2,
                                                    lineSpacing: 5))),
                                      ],
                                    );
                                  }).toList()
                                ]))),

                    //RIGHT SIDE
                   pw.Flexible(child:  pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(resume.profile.name.toUpperCase(),
                                textScaleFactor: 2,
                                textAlign: pw.TextAlign.start,
                                style: pw.TextStyle(
                                    color: PdfColor.fromHex("#062A6D"),
                                    fontWeight: pw.FontWeight.bold,
                                    letterSpacing: 6)),
                            pw.SizedBox(height: 10),
                            pw.Text(resume.profile.title,
                                textScaleFactor: 1.2,
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    letterSpacing: 3)),
                            pw.SizedBox(height: 20),
                            BodyText(resume.profile.profileSummary, ttfRegular),
                            pw.SizedBox(height: 20),
                            GreyHeading("Work Experience"),
                            pw.SizedBox(height: 10),
                            ...resume.workExperience.map((e) {
                              return pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
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
                                          padding:
                                              const pw.EdgeInsets.symmetric(
                                                  vertical: 3.0),
                                          child: pw.Row(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Padding(
                                                  padding:
                                                      const pw.EdgeInsets.only(
                                                          top: 4.0, right: 5.0),
                                                  child: pw.Container(
                                                    height: 4,
                                                    width: 4,
                                                    decoration:
                                                        const pw.BoxDecoration(
                                                      color: PdfColor.fromInt(
                                                          0x000000),
                                                      shape: pw.BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                               pw.Flexible(child:  BodyText(item, ttfRegular),)
                                              ]));

                                    }).toList(),
                                    pw.SizedBox(height: 10)
                                  ]);
                            }).toList()
                          ],
                        ))
                  )
                  
                  ])),
    );
  }
}

class _CustomHeading extends pw.StatelessWidget {
  final String text;

  _CustomHeading(this.text);

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 18,
          color: PdfColors.black,
        ),
      ),
    );
  }
}
