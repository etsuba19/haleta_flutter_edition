import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/study/entities/study_topic.dart';
import '../../application/study/study_notifier.dart';
import '../topic_detail/topic_detail_page.dart';
import 'study_provider.dart';

class StudyController {
  final Ref ref;

  StudyController(this.ref);

  void onTopicSelected(StudyTopic topic, BuildContext context) {
    // Update UI state
    ref.read(studyUIProvider.notifier).selectTopic(topic);
    
    // Navigate to topic detail page
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TopicDetailPage(
          topicId: topic.id,
          topicTitle: topic.title,
          topicAmharicTitle: topic.amharicTitle,
        ),
      ),
    );
  }

  void onBackPressed() {
    // Close menu if open, otherwise navigate back
    final uiState = ref.read(studyUIProvider);
    if (uiState.isMenuOpen) {
      ref.read(studyUIProvider.notifier).closeMenu();
    } else {
      print('Navigating back to main menu');
      // TODO: Implement back navigation logic here
      // Example: context.pop();
    }
  }

  void onMenuToggle() {
    ref.read(studyUIProvider.notifier).toggleMenu();
  }

  void onRetryPressed() {
    // Hide retry button and reload topics
    ref.read(studyUIProvider.notifier).hideRetry();
    ref.read(studyNotifierProvider.notifier).loadStudyTopics();
  }

  void onLoadError() {
    // Show retry button when there's an error
    ref.read(studyUIProvider.notifier).showRetry();
  }

  void initializePage() {
    // Load study topics when page initializes
    ref.read(studyNotifierProvider.notifier).loadStudyTopics();
  }
}

final studyControllerProvider = Provider<StudyController>((ref) {
  return StudyController(ref);
}); 