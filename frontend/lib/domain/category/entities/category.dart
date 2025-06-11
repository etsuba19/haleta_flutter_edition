import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final int quizCount;

  const Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.quizCount = 0,
  });

  @override
  List<Object> get props => [id, name, imageUrl, quizCount];
} 