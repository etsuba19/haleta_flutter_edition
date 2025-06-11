import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../infrastructure/auth/auth_provider.dart';

class LoginController extends StateNotifier<LoginState> {
  final Ref _ref;

  LoginController(this._ref) : super(LoginState.initial());

  void setUsername(String value) {
    state = state.copyWith(username: value);
  }

  void setPassword(String value) {
    state = state.copyWith(password: value);
  }

  void setRole(String value) {
    state = state.copyWith(role: value);
  }

  Future<bool> login() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      final authController = _ref.read(authControllerProvider);
      final success = await authController.login(
        state.username,
        state.password,
        state.role.isEmpty ? 'student' : state.role, // Default to student if role not selected
      );
      
      state = state.copyWith(isLoading: false, isAuthenticated: success);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }
}

class LoginState {
  final String username;
  final String password;
  final String role;
  final bool isLoading;
  final bool isAuthenticated;
  final String? errorMessage;

  LoginState({
    required this.username,
    required this.password,
    required this.role,
    required this.isLoading,
    required this.isAuthenticated,
    this.errorMessage,
  });

  factory LoginState.initial() {
    return LoginState(
      username: '',
      password: '',
      role: 'student', // Default role
      isLoading: false,
      isAuthenticated: false,
    );
  }

  LoginState copyWith({
    String? username,
    String? password,
    String? role,
    bool? isLoading,
    bool? isAuthenticated,
    String? errorMessage,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      role: role ?? this.role,
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      errorMessage: errorMessage,
    );
  }
}

final loginControllerProvider = StateNotifierProvider<LoginController, LoginState>(
  (ref) => LoginController(ref),
);
