import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/presentation/admin_home/admin_home_page.dart';
import 'presentation/resources/resources_controller.dart';
import 'domain/resources/entities/resource.dart';

void main() {
  runApp(
    ProviderScope(
      overrides: [
        getResourcesProvider.overrideWithValue(() async => List.generate(
          7,
              (i) => Resource(
            id: '${i + 1}',
            title: 'ResourceID',
            description: 'Resource ${i + 1}',
            url: 'https://example.com/${i + 1}',
          ),
        )),
        removeResourceProvider.overrideWithValue((String id) async {}),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: AdminHomePage());
  }
}