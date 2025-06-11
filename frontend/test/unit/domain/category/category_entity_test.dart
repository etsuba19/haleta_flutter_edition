import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domain/category/entities/category.dart';

void main() {
  group('Category Entity', () {
    test('should create a valid category entity', () {
      final category = Category(
        id: '1',
        title: 'General Knowledge',
        subtitle: 'A variety of questions',
      );

      expect(category.id, '1');
      expect(category.title, 'General Knowledge');
      expect(category.subtitle, 'A variety of questions');
    });
  });
}
