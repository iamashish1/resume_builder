import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:resume_builder/core/app_exceptions/app_exceptions.dart';

abstract class Usecase<T, V> {
  Future<Either<AppException, T>> call(V params);
}

// Define a NoParams class
// Extending Equatable does not make any difference for now
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
