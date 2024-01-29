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

Template1Model sampleData = Template1Model(
  name: "John Doe",
  position: "Software Engineer",
  phoneNumber: "+1234567890",
  email: "john.doe@example.com",
  yourPortfolioSite: "",
  profileSummary:
      "Experienced software engineer with a passion for building innovative solutions. The software engineer with a passion for building innovative solutions.Experienced software engineer with a passion for building innovative solutions.Experienced software engineer with a passion for building innovative solutions.Experienced software engineer with a passion for building innovative solutions.Experienced software engineer with a passion for building innovative solutions.",
  workExperience: [
    WorkExperience(
      designation: "Senior Software Engineer",
      companyName: "Tech Solutions Inc.",
      dateRange: "January 2020 - Present",
      jobResponsibilities: [
        "Lead a team of developers in the implementation of a new project.",
        "Designed and developed core functionalities for the project.",
        "Collaborated with stakeholders to gather requirements and provide technical solutions."
      ],
    ),
    WorkExperience(
      designation: "Software Engineer",
      companyName: "Code Masters Ltd.",
      dateRange: "July 2017 - December 2019",
      jobResponsibilities: [
        "Developed and maintained web applications using modern technologies.",
        "Participated in code reviews and provided constructive feedback.",
        "Assisted in the recruitment process by conducting technical interviews."
      ],
    ),
  ],
  education: [
    Education(
      university: "University of Computer Science",
      studyDateRange: "2013 - 2017",
      studyCourse: "Bachelor of Science in Computer Science",
    ),
  ],
  certifications: [
    "AWS Certified Solutions Architect - Associate",
    "Google Certified Professional Cloud Architect",
  ],
  skills: [
    "JavaScript",
    "Python",
    "React",
    "Node.js",
    "Docker",
    "SQL",
  ],
);
