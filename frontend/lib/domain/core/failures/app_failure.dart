import 'package:equatable/equatable.dart';

abstract class AppFailure extends Equatable {
  final String message;

  const AppFailure(this.message);

  factory AppFailure.serverError(String message) = ServerFailure;

  @override
  List<Object> get props => [message];
}

class ServerFailure extends AppFailure {
  const ServerFailure(String message) : super(message);
}

class CacheFailure extends AppFailure {
  const CacheFailure(String message) : super(message);
}

class NetworkFailure extends AppFailure {
  const NetworkFailure(String message) : super(message);
}

class InvalidInputFailure extends AppFailure {
  const InvalidInputFailure(String message) : super(message);
}