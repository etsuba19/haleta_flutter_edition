import 'package:flutter/material.dart';
import '../../domain/previous_exam/previous_exam.dart';
import 'view_previous_exam.dart';
import 'continue_previous_exam.dart';

class PreviousExamState {
  final String firstQuizId;
  final String secondQuizId;

  PreviousExamState({this.firstQuizId = '', this.secondQuizId = ''});

  PreviousExamState copyWith({String? firstQuizId, String? secondQuizId}) {
    return PreviousExamState(
      firstQuizId: firstQuizId ?? this.firstQuizId,
      secondQuizId: secondQuizId ?? this.secondQuizId,
    );
  }
}

class PreviousExamNotifier extends ChangeNotifier {
  PreviousExamState _uiState = PreviousExamState();
  final ViewPreviousExam _view;
  final ContinuePreviousExam _continue;

  PreviousExamNotifier({
    required ViewPreviousExam view,
    required ContinuePreviousExam continueUseCase,
  })  : _view = view,
        _continue = continueUseCase;

  PreviousExamState get uiState => _uiState;

  void onFirstQuizIdChange(String id) {
    _uiState = _uiState.copyWith(firstQuizId: id);
    notifyListeners();
  }

  void onSecondQuizIdChange(String id) {
    _uiState = _uiState.copyWith(secondQuizId: id);
    notifyListeners();
  }

  void onViewClicked() {
    _view.call(PreviousExam(id: _uiState.firstQuizId));
  }

  void onContinueClicked() {
    _continue.call(PreviousExam(id: _uiState.secondQuizId));
  }
}
