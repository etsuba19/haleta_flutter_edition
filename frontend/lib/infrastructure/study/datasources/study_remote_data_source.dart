import '../../../domain/study/entities/study_topic.dart';

abstract class StudyRemoteDataSource {
  Future<List<StudyTopic>> getStudyTopics();
}

class StudyRemoteDataSourceImpl implements StudyRemoteDataSource {
  @override
  Future<List<StudyTopic>> getStudyTopics() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    // Return the topics shown in the screenshot
    return const [
      StudyTopic(
        id: '1',
        title: 'Pronouns',
        amharicTitle: 'መርዛዊት',
        description: 'Learn about Amharic pronouns',
        isAvailable: true,
        itemCount: 25,
      ),
      StudyTopic(
        id: '2',
        title: 'Verbs',
        amharicTitle: 'ግስ',
        description: 'Learn about Amharic verbs',
        isAvailable: true,
        itemCount: 40,
      ),
      StudyTopic(
        id: '3',
        title: 'Nouns',
        amharicTitle: 'ስም',
        description: 'Learn about Amharic nouns',
        isAvailable: true,
        itemCount: 35,
      ),
      StudyTopic(
        id: '4',
        title: 'Adjectives',
        amharicTitle: 'ቅጽል',
        description: 'Learn about Amharic adjectives',
        isAvailable: true,
        itemCount: 20,
      ),
      StudyTopic(
        id: '5',
        title: 'Numbers',
        amharicTitle: 'አሃዝ',
        description: 'Learn about Amharic numbers',
        isAvailable: true,
        itemCount: 15,
      ),
      // Example of an unavailable topic (won't show in UI)
      StudyTopic(
        id: '6',
        title: 'Advanced Grammar',
        amharicTitle: 'የላቀ ሰዋሰው',
        description: 'Advanced Amharic grammar rules',
        isAvailable: false,
        itemCount: 0,
      ),
    ];
  }
} 