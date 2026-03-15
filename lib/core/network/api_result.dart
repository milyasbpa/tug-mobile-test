import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

/// Shorthand for async repository return types: Either a Failure or a value.
typedef ApiResult<T> = Future<Either<Failure, T>>;
