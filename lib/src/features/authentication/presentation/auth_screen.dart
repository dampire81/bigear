import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bigear/src/features/authentication/data/auth_repository.dart';
import 'package:bigear/src/features/authentication/presentation/account_screen.dart';
import 'package:bigear/src/features/authentication/presentation/sign_in_screen.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);
    return authState.maybeWhen(
      data: (user) =>
          user != null ? const AccountScreen() : const SignInScreen(),
      // TODO: Should also handle errors
      orElse: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
