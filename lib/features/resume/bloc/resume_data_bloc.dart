import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resume_builder/features/home/template_model/template_model.dart';

class ResumeDataBloc extends Cubit<ResumeModel> {
  ResumeDataBloc() : super(ResumeModel());

  void updateField(ResumeModel model) {
    emit(model);
  }

  void addExperience<T>() {
    // (T is WorkExperience) evaluates to false
    // T.runtimeType() prints "Type"
    // T is not a concrete type at runtime
    List<WorkExperience> listOfExperiences = state.workExperience ?? [];
    listOfExperiences.add(WorkExperience());
    emit(state.copyWith(workExperience: listOfExperiences));
  }

  void addEducation() {
    List<Education> listOfEducations = state.education ?? [];
    listOfEducations.add(Education());
    emit(state.copyWith(education: listOfEducations));
  }

  void submit() {}
}
