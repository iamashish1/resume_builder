class Profile {
  String title;
  String name;
  String position;
  String phoneNumber;
  String email;
  String yourPortfolioSite;

  String profileSummary;
  Profile(
      {this.email = "",
      this.title = "",
      this.name = "",
      this.phoneNumber = "",
      this.position = "",
      this.profileSummary = "",
      this.yourPortfolioSite = ""});
}

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
    required this.jobResponsibilities,
  });
}

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

class ResumeModel {
  int id;
  Profile profile;
  List<WorkExperience> workExperience;
  List<Education> education;
  List<String> skills;

  ResumeModel(
      {required this.id,
      required this.profile,
      required this.workExperience,
      required this.education,
      required this.skills});
}
