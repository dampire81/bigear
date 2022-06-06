import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bigear/src/features/authentication/data/auth_repository.dart';

class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  AccountScreenController({required this.authRepository})
      : super(const AsyncData(null));
  final AuthRepository authRepository;

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(authRepository.signOut);
  }
}

final accountScreenControllerProvider = StateNotifierProvider.autoDispose<AccountScreenController, AsyncValue<void>>((ref) {
  return AccountScreenController(
    authRepository: ref.watch(authRepositoryProvider),
  );
});
