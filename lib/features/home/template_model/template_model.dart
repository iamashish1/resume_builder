import 'package:copy_with_extension/copy_with_extension.dart';
part 'template_model.g.dart';

@CopyWith()
class Profile {
  String? name;
  String? position;
  String? phoneNumber;
  String? email;
  String? yourPortfolioSite;

  String? profileSummary;
  Profile(
      {this.email = "",
      this.name = "",
      this.phoneNumber = "",
      this.position = "",
      this.profileSummary = "",
      this.yourPortfolioSite = ""});
}

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
  Profile? profile;
  List<WorkExperience>? workExperience;
  List<Education>? education;
  List<String>? certifications;
  List<String>? skills;

  ResumeModel(
      {this.profile,
      this.workExperience,
      this.education,
      this.certifications,
      this.skills});
}
