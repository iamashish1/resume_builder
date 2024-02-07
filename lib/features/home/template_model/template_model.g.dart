// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WorkExperienceCWProxy {
  WorkExperience designation(String designation);

  WorkExperience companyName(String companyName);

  WorkExperience startDate(String startDate);

  WorkExperience endDate(String endDate);

  WorkExperience isCurrentlyWorking(bool isCurrentlyWorking);

  WorkExperience jobResponsibilities(List<String> jobResponsibilities);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WorkExperience(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WorkExperience(...).copyWith(id: 12, name: "My name")
  /// ````
  WorkExperience call({
    String? designation,
    String? companyName,
    String? startDate,
    String? endDate,
    bool? isCurrentlyWorking,
    List<String>? jobResponsibilities,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWorkExperience.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWorkExperience.copyWith.fieldName(...)`
class _$WorkExperienceCWProxyImpl implements _$WorkExperienceCWProxy {
  const _$WorkExperienceCWProxyImpl(this._value);

  final WorkExperience _value;

  @override
  WorkExperience designation(String designation) =>
      this(designation: designation);

  @override
  WorkExperience companyName(String companyName) =>
      this(companyName: companyName);

  @override
  WorkExperience startDate(String startDate) => this(startDate: startDate);

  @override
  WorkExperience endDate(String endDate) => this(endDate: endDate);

  @override
  WorkExperience isCurrentlyWorking(bool isCurrentlyWorking) =>
      this(isCurrentlyWorking: isCurrentlyWorking);

  @override
  WorkExperience jobResponsibilities(List<String> jobResponsibilities) =>
      this(jobResponsibilities: jobResponsibilities);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WorkExperience(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WorkExperience(...).copyWith(id: 12, name: "My name")
  /// ````
  WorkExperience call({
    Object? designation = const $CopyWithPlaceholder(),
    Object? companyName = const $CopyWithPlaceholder(),
    Object? startDate = const $CopyWithPlaceholder(),
    Object? endDate = const $CopyWithPlaceholder(),
    Object? isCurrentlyWorking = const $CopyWithPlaceholder(),
    Object? jobResponsibilities = const $CopyWithPlaceholder(),
  }) {
    return WorkExperience(
      designation:
          designation == const $CopyWithPlaceholder() || designation == null
              ? _value.designation
              // ignore: cast_nullable_to_non_nullable
              : designation as String,
      companyName:
          companyName == const $CopyWithPlaceholder() || companyName == null
              ? _value.companyName
              // ignore: cast_nullable_to_non_nullable
              : companyName as String,
      startDate: startDate == const $CopyWithPlaceholder() || startDate == null
          ? _value.startDate
          // ignore: cast_nullable_to_non_nullable
          : startDate as String,
      endDate: endDate == const $CopyWithPlaceholder() || endDate == null
          ? _value.endDate
          // ignore: cast_nullable_to_non_nullable
          : endDate as String,
      isCurrentlyWorking: isCurrentlyWorking == const $CopyWithPlaceholder() ||
              isCurrentlyWorking == null
          ? _value.isCurrentlyWorking
          // ignore: cast_nullable_to_non_nullable
          : isCurrentlyWorking as bool,
      jobResponsibilities:
          jobResponsibilities == const $CopyWithPlaceholder() ||
                  jobResponsibilities == null
              ? _value.jobResponsibilities
              // ignore: cast_nullable_to_non_nullable
              : jobResponsibilities as List<String>,
    );
  }
}

extension $WorkExperienceCopyWith on WorkExperience {
  /// Returns a callable class that can be used as follows: `instanceOfWorkExperience.copyWith(...)` or like so:`instanceOfWorkExperience.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WorkExperienceCWProxy get copyWith => _$WorkExperienceCWProxyImpl(this);
}

abstract class _$EducationCWProxy {
  Education university(String? university);

  Education studyDateRange(String? studyDateRange);

  Education studyCourse(String? studyCourse);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Education(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Education(...).copyWith(id: 12, name: "My name")
  /// ````
  Education call({
    String? university,
    String? studyDateRange,
    String? studyCourse,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfEducation.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfEducation.copyWith.fieldName(...)`
class _$EducationCWProxyImpl implements _$EducationCWProxy {
  const _$EducationCWProxyImpl(this._value);

  final Education _value;

  @override
  Education university(String? university) => this(university: university);

  @override
  Education studyDateRange(String? studyDateRange) =>
      this(studyDateRange: studyDateRange);

  @override
  Education studyCourse(String? studyCourse) => this(studyCourse: studyCourse);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Education(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Education(...).copyWith(id: 12, name: "My name")
  /// ````
  Education call({
    Object? university = const $CopyWithPlaceholder(),
    Object? studyDateRange = const $CopyWithPlaceholder(),
    Object? studyCourse = const $CopyWithPlaceholder(),
  }) {
    return Education(
      university: university == const $CopyWithPlaceholder()
          ? _value.university
          // ignore: cast_nullable_to_non_nullable
          : university as String?,
      studyDateRange: studyDateRange == const $CopyWithPlaceholder()
          ? _value.studyDateRange
          // ignore: cast_nullable_to_non_nullable
          : studyDateRange as String?,
      studyCourse: studyCourse == const $CopyWithPlaceholder()
          ? _value.studyCourse
          // ignore: cast_nullable_to_non_nullable
          : studyCourse as String?,
    );
  }
}

extension $EducationCopyWith on Education {
  /// Returns a callable class that can be used as follows: `instanceOfEducation.copyWith(...)` or like so:`instanceOfEducation.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EducationCWProxy get copyWith => _$EducationCWProxyImpl(this);
}

abstract class _$ResumeModelCWProxy {
  ResumeModel name(String? name);

  ResumeModel position(String? position);

  ResumeModel phoneNumber(String? phoneNumber);

  ResumeModel email(String? email);

  ResumeModel yourPortfolioSite(String? yourPortfolioSite);

  ResumeModel profileSummary(String? profileSummary);

  ResumeModel workExperience(List<WorkExperience>? workExperience);

  ResumeModel education(List<Education>? education);

  ResumeModel certifications(List<String>? certifications);

  ResumeModel skills(List<String>? skills);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ResumeModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ResumeModel(...).copyWith(id: 12, name: "My name")
  /// ````
  ResumeModel call({
    String? name,
    String? position,
    String? phoneNumber,
    String? email,
    String? yourPortfolioSite,
    String? profileSummary,
    List<WorkExperience>? workExperience,
    List<Education>? education,
    List<String>? certifications,
    List<String>? skills,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfResumeModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfResumeModel.copyWith.fieldName(...)`
class _$ResumeModelCWProxyImpl implements _$ResumeModelCWProxy {
  const _$ResumeModelCWProxyImpl(this._value);

  final ResumeModel _value;

  @override
  ResumeModel name(String? name) => this(name: name);

  @override
  ResumeModel position(String? position) => this(position: position);

  @override
  ResumeModel phoneNumber(String? phoneNumber) =>
      this(phoneNumber: phoneNumber);

  @override
  ResumeModel email(String? email) => this(email: email);

  @override
  ResumeModel yourPortfolioSite(String? yourPortfolioSite) =>
      this(yourPortfolioSite: yourPortfolioSite);

  @override
  ResumeModel profileSummary(String? profileSummary) =>
      this(profileSummary: profileSummary);

  @override
  ResumeModel workExperience(List<WorkExperience>? workExperience) =>
      this(workExperience: workExperience);

  @override
  ResumeModel education(List<Education>? education) =>
      this(education: education);

  @override
  ResumeModel certifications(List<String>? certifications) =>
      this(certifications: certifications);

  @override
  ResumeModel skills(List<String>? skills) => this(skills: skills);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ResumeModel(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ResumeModel(...).copyWith(id: 12, name: "My name")
  /// ````
  ResumeModel call({
    Object? name = const $CopyWithPlaceholder(),
    Object? position = const $CopyWithPlaceholder(),
    Object? phoneNumber = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? yourPortfolioSite = const $CopyWithPlaceholder(),
    Object? profileSummary = const $CopyWithPlaceholder(),
    Object? workExperience = const $CopyWithPlaceholder(),
    Object? education = const $CopyWithPlaceholder(),
    Object? certifications = const $CopyWithPlaceholder(),
    Object? skills = const $CopyWithPlaceholder(),
  }) {
    return ResumeModel(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      position: position == const $CopyWithPlaceholder()
          ? _value.position
          // ignore: cast_nullable_to_non_nullable
          : position as String?,
      phoneNumber: phoneNumber == const $CopyWithPlaceholder()
          ? _value.phoneNumber
          // ignore: cast_nullable_to_non_nullable
          : phoneNumber as String?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      yourPortfolioSite: yourPortfolioSite == const $CopyWithPlaceholder()
          ? _value.yourPortfolioSite
          // ignore: cast_nullable_to_non_nullable
          : yourPortfolioSite as String?,
      profileSummary: profileSummary == const $CopyWithPlaceholder()
          ? _value.profileSummary
          // ignore: cast_nullable_to_non_nullable
          : profileSummary as String?,
      workExperience: workExperience == const $CopyWithPlaceholder()
          ? _value.workExperience
          // ignore: cast_nullable_to_non_nullable
          : workExperience as List<WorkExperience>?,
      education: education == const $CopyWithPlaceholder()
          ? _value.education
          // ignore: cast_nullable_to_non_nullable
          : education as List<Education>?,
      certifications: certifications == const $CopyWithPlaceholder()
          ? _value.certifications
          // ignore: cast_nullable_to_non_nullable
          : certifications as List<String>?,
      skills: skills == const $CopyWithPlaceholder()
          ? _value.skills
          // ignore: cast_nullable_to_non_nullable
          : skills as List<String>?,
    );
  }
}

extension $ResumeModelCopyWith on ResumeModel {
  /// Returns a callable class that can be used as follows: `instanceOfResumeModel.copyWith(...)` or like so:`instanceOfResumeModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ResumeModelCWProxy get copyWith => _$ResumeModelCWProxyImpl(this);
}
