import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/auth/login_page.dart';
import '../presentation/home/home_page.dart';
import '../presentation/quiz/quiz_controller.dart';
import '../presentation/security_question/security_question_page.dart';
import '../presentation/signup/signup_page.dart';
import '../presentation/choice/choice_page.dart';
import '../presentation/forgot_password/forgot_password_page.dart';
import '../presentation/answer_security/answer_security_page.dart';
import '../presentation/reset_password/reset_password_page.dart';

import '../presentation/category/category_page.dart';
import '../presentation/profile/profile_page.dart';
import '../presentation/quiz/quiz_page.dart';
import '../presentation/result/result_page.dart';
import '../presentation/study/study_page.dart';
import '../presentation/topic_detail/topic_detail_page.dart';

typedef DrawerCallback = void Function(String);

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => SignupScreen(),
    ),
    GoRoute(
      path: '/security-question',
      builder: (context, state) => SecurityQuestionPage(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/answer-security',
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>? ?? {};
        final username = args['username'] as String? ?? '';
        
        return SecurityQuestionsPage(username: username);
      },
    ),
    GoRoute(
      path: '/reset-password',
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>? ?? {};
        final username = args['username'] as String? ?? '';
        
        return ResetPasswordPage(username: username);
      },
    ),
    GoRoute(
      path: '/choice',
      builder: (context, state) => ChoiceScreen(),
    ),
    GoRoute(
      path: '/study',
      builder: (context, state) => StudyPage(),
    ),
    GoRoute(
      path: '/topic-detail',
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>? ?? {};
        return TopicDetailPage(
          topicId: args['topicId'] as String? ?? '',
          topicTitle: args['topicTitle'] as String? ?? '',
          topicAmharicTitle: args['topicAmharicTitle'] as String? ?? '',
        );
      },
    ),
    GoRoute(
      path: '/category',
      builder: (context, state) {
        return CategoryPage(
          currentPage: 'ጥያቄ - ፈተና ክብደት',
          onDifficultySelected: (String selectedDifficulty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                context.go('/quiz', extra: {
                  'difficulty': selectedDifficulty,
                  'viewModel': QuizViewModel(
                    questionText: 'እርሱ ብሎ ውእቱ ካለ እርሷ ብሎ ____',
                    options: ['ውእቱ', 'ይቲ', 'አንቲ', 'ይእቲ'],
                    correctAnswer: 'ይእቲ',
                  ),
                  'onNextClick': () {
                    if (context.mounted) {
                      context.go('/result', extra: {
                        'score': 9,
                        'total': 10,
                        'onDrawerItemClick': (String item) =>
                            _handleDrawerNavigation(context, item),
                        'onBackClick': () => context.pop(),
                        'onNextClick': () => context.go('/category'),
                        'currentPage': 'ውጤት',
                      });
                    }
                  },
                });
              }
            });
          },
          onDrawerItemClick: (item) => _handleDrawerNavigation(context, item),
        );
      },
    ),
    GoRoute(
      path: '/quiz',
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>? ?? {};
        final viewModel = args['viewModel'] as QuizViewModel? ??
            QuizViewModel(
              questionText: 'Default question?',
              options: ['A', 'B', 'C', 'D'],
              correctAnswer: 'A',
            );
        final onNextClick = args['onNextClick'] as VoidCallback? ?? () {};

        return QuizScreen(
          viewModel: viewModel,
          onNextClick: onNextClick,
        );
      },
    ),
    GoRoute(
      path: '/result',
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>? ?? {};
        return ResultScreen(
          score: args['score'] as int? ?? 0,
          total: args['total'] as int? ?? 0,
          onDrawerItemClick: (item) {
            _handleDrawerNavigation(context, item);
          },
          onBackClick: args['onBackClick'] as VoidCallback? ?? () {},
          onNextClick: args['onNextClick'] as VoidCallback? ?? () {},
          currentPage: args['currentPage'] as String? ?? 'ውጤት',
        );
      },
    ),


    GoRoute(
      path: '/profile',
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>? ?? {};
        final onBackClick = args['onBackClick'] as VoidCallback? ?? () {};

        return ProfileScreen(
          currentPage: 'መለያ',
          onDrawerItemClick: (item) {
            final routeMap = {
              "መለያ": "/profile",
              "ጥያቄ - ፈተና ክብደት": "/category",
              "የፈተና ማህደር": "",
              "ንባብ": "",
            };

            final currentRoute = GoRouterState.of(context).uri.toString();
            final targetRoute = routeMap[item];

            if (targetRoute != null &&
                targetRoute.isNotEmpty &&
                currentRoute != targetRoute) {
              GoRouter.of(context).go(targetRoute, extra: {
                'onDrawerItemClick': (String item) =>
                    _handleDrawerNavigation(context, item),
                'onBackClick': onBackClick,
                'currentPage': item,
              });
            }
          },
          onBackClick: onBackClick,
        );
      },
    ),
  ],
);

void _handleDrawerNavigation(BuildContext context, String item) {
  final currentRoute = GoRouterState.of(context).uri.toString();

  print('Drawer clicked: $item, currentRoute: $currentRoute');

  switch (item) {
    case 'መለያ': // Profile
      if (currentRoute != '/profile') {
        Future.microtask(() {
          context.go('/profile', extra: {
            'onDrawerItemClick': (String item) =>
                _handleDrawerNavigation(context, item),
            'onBackClick': () => context.pop(),
            'currentPage': 'መለያ',
          });
        });
      }
      break;

    case 'ጥያቄ - ፈተና ክብደት': // Category
      if (currentRoute != '/category') {
        Future.microtask(() {
          context.go('/category');
        });
      }
      break;

    case 'ንባብ': // Study
      if (currentRoute != '/study') {
        Future.microtask(() {
          context.go('/study');
        });
      }
      break;

    case 'close':
    // You can add drawer closing logic here if needed
      break;

    default:
      print('No route mapping for drawer item: $item');
      break;
  }
}