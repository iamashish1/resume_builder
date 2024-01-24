class WorkExperience {
  String? designation;
  String? companyName;
  String? dateRange;
  List<String>? jobResponsibilities;

  WorkExperience({
    this.designation,
    this.companyName,
    this.dateRange,
    this.jobResponsibilities,
  });
}

class Education {
  String? university;
  String? studyDateRange;
  String? studyCourse;

  Education({
    this.university,
    this.studyDateRange,
    this.studyCourse,
  });
}

class Template1Model {
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
  Template1Model(
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
