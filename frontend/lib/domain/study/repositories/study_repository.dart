import '../entities/study_topic.dart';

abstract class StudyRepository {
  Future<List<StudyTopic>> fetchStudyTopics();
  Future<StudyTopic> getStudyTopicById(String id);
} 