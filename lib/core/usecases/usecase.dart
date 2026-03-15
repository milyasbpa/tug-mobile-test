import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

// ignore: one_member_abstracts, use cases by definition have one call() method
abstract interface class UseCase<Output, Params> {
  Future<Either<Failure, Output>> call(Params params);
}

final class NoParams {
  const NoParams();
}
