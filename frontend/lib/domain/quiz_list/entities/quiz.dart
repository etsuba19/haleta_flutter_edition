// lib/domain/quiz_list/entities/quiz.dart
import 'package:equatable/equatable.dart';

class Quiz extends Equatable {
  final String id;
  final String title;

  const Quiz({required this.id, required this.title});

  @override
  List<Object> get props => [id, title];
}