import 'package:copy_with_extension/copy_with_extension.dart';
part 'template_model.g.dart';

@CopyWith()
class WorkExperience {
  String designation;
  String companyName;
  String startDate;
  String endDate;
  List<String> jobResponsibilities;
  bool isCurrentlyWorking;

  WorkExperience({
    this.designation = '',
    this.companyName = '',
    this.startDate = '',
    this.endDate = '',
    this.isCurrentlyWorking = false,
    this.jobResponsibilities = const [""],
  });
}

@CopyWith()
class Education {
  String university;
  String startDate;
  String endDate;
  String studyCourse;
  bool isCurrentlyStudying;

  Education({
    this.university = "",
    this.startDate = '',
    this.endDate = '',
    this.studyCourse = '',
    this.isCurrentlyStudying = false,
  });
}

@CopyWith()
class ResumeModel {
  // Section 1
  String? name;
  String? position;
  String? phoneNumber;
  String? email;
  String? yourPortfolioSite;

  // Section 2
  String? profileSummary;

  // Section 3
  List<WorkExperience>? workExperience;

  // Section 4
  List<Education>? education;

  //Section 5
  List<String>? certifications;

  //Section 6
  List<String>? skills;

  // Constructor
  ResumeModel(
      {this.name,
      this.position,
      this.phoneNumber,
      this.email,
      this.yourPortfolioSite,
      this.profileSummary,
      this.workExperience,
      this.education,
      this.certifications,
      this.skills});
}

// ResumeModel sampleData = ResumeModel(
//   name: "John Doe",
//   position: "Software Engineer",
//   phoneNumber: "+1234567890",
//   email: "john.doe@example.com",
//   yourPortfolioSite: "",
//   profileSummary:
//       "Experienced software engineer with a passion for building innovative solutions. The software engineer with a passion for building innovative solutions.Experienced software engineer with a passion for building innovative solutions.Experienced software engineer with a passion for building innovative solutions.Experienced software engineer with a passion for building innovative solutions.Experienced software engineer with a passion for building innovative solutions.",
//   workExperience: [
//     WorkExperience(
//       designation: "Senior Software Engineer",
//       companyName: "Tech Solutions Inc.",
//       dateRange: "January 2020 - Present",
//       jobResponsibilities: [
//         "Lead a team of developers in the implementation of a new project.",
//         "Designed and developed core functionalities for the project.",
//         "Collaborated with stakeholders to gather requirements and provide technical solutions."
//       ],
//     ),
//     WorkExperience(
//       designation: "Software Engineer",
//       companyName: "Code Masters Ltd.",
//       dateRange: "July 2017 - December 2019",
//       jobResponsibilities: [
//         "Developed and maintained web applications using modern technologies.",
//         "Participated in code reviews and provided constructive feedback.",
//         "Assisted in the recruitment process by conducting technical interviews."
//       ],
//     ),
//   ],
//   education: [
//     Education(
//       university: "University of Computer Science",
//       studyDateRange: "2013 - 2017",
//       studyCourse: "Bachelor of Science in Computer Science",
//     ),
//   ],
//   certifications: [
//     "AWS Certified Solutions Architect - Associate",
//     "Google Certified Professional Cloud Architect",
//   ],
//   skills: [
//     "JavaScript",
//     "Python",
//     "React",
//     "Node.js",
//     "Docker",
//     "SQL",
//   ],
// );
