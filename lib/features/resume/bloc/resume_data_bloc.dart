import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resume_builder/features/home/template_model/template_model.dart';

class ResumeDataBloc extends Cubit<ResumeModel> {
  ResumeDataBloc() : super(ResumeModel());

  //Profile Update Part

  updateName(String name) {
    emit(state.copyWith(name: name));
  }

  updatePhone(String phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  updatePortfolio(String portfolio) {
    emit(state.copyWith(yourPortfolioSite: portfolio));
  }

  updateSummary(String summary) {
    emit(state.copyWith(profileSummary: summary));
  }

  //Experience update Part

  void addExperience() {
    List<WorkExperience> listOfExperiences =
        List.from(state.workExperience ?? []);
    listOfExperiences.add(WorkExperience());
    emit(state.copyWith(workExperience: listOfExperiences));
  }

  void addCompanyName(String companyName, int index) {
    List<WorkExperience?> newList = List.from(state.workExperience ?? []);
    newList[index] = newList[index]?.copyWith(companyName: companyName);

    emit(state.copyWith(
      workExperience: newList,
    ));
  }

  void addPosition(String position, int index) {
    List<WorkExperience?> newList = List.from(state.workExperience ?? []);
    newList[index] = newList[index]?.copyWith(designation: position);

    emit(state.copyWith(
      workExperience: newList,
    ));
  }

  void addJobResponsibility(int index) {
    List<WorkExperience> newWorkExpList = List.from(state.workExperience ?? []);
    List<String> newJobResponsibility =
        List.from(newWorkExpList[index].jobResponsibilities);
    newJobResponsibility.add("");
    newWorkExpList[index].jobResponsibilities = newJobResponsibility;
    emit(state.copyWith(workExperience: newWorkExpList));
  }

  //Education update Part

  void addEducation() {
    List<Education> listOfEducations = state.education ?? [];
    listOfEducations.add(Education());
    emit(state.copyWith(education: listOfEducations));
  }

  //Skills Update Part
}
