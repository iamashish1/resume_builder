import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resume_builder/features/home/template_model/template_model.dart';

class ResumeDataBloc extends Cubit<ResumeModel> {
  ResumeDataBloc() : super(ResumeModel());

  void updateField(ResumeModel model) {
    emit(model);
  }

  void addExperience() {
    List<WorkExperience> listOfExperiences = state.workExperience ?? [];

    listOfExperiences.add(WorkExperience());

    emit(state.copyWith(workExperience: listOfExperiences));
  }

  void submit() {}
}
