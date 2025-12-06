import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tick_it/core/netowoks/api_error_model.dart';

part 'api_result.freezed.dart';

@Freezed()
abstract class ApiResult<T> with _$ApiResult<T> {
  factory ApiResult.success(T data) = Success<T>;
  factory ApiResult.failure(ApiErrorModel error) = Failure<T>;
}
