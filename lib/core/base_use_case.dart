
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:newsapp/core/error/error.dart';

abstract class BaseUseCase<T> {
  Future<Either<Failure,T>> call();
}


