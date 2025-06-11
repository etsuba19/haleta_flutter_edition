// test/unit/domain/choice/choice_entity_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domain/choice/entities/choice.dart';

void main() {
  group('Choice Entity', () {
    test('should create a valid Choice instance', () {
      final choice = Choice(id: '1', name: 'Quiz');

      expect(choice.id, '1');
      expect(choice.name, 'Quiz');
    });
  });
}
