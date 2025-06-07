// import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentation/login/login_screen.dart';
import '../presentation/home/home_screen.dart';
import '../presentation/security_question/security_question_screen.dart';
import '../presentation/signup/signup_screen.dart';
import '../presentation/choice/choice_screen.dart';

final GoRouter router = GoRouter(

  initialLocation: '/',

  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => SignupScreen(), // not const if using ConsumerWidget
    ),
    GoRoute(
      path: '/security-question',
      builder: (context, state) => SecurityQuestionScreen(), // not const if using ConsumerWidget
    ),
    GoRoute(
      path: '/choice',
      builder: (context, state) => ChoiceScreen(), // not const if using ConsumerWidget
    ),
  ],
);
