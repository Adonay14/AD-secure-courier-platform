import 'package:riverpod_annotation/riverpod_annotation.dart';
  part 'loading_state_provider.g.dart';


@riverpod
class LoadingStateNotifier extends _$LoadingStateNotifier {
  @override
  bool build() => true; // Initial state

  // Method to toggle the state
  void toggle() {
    state = !state;
  }

  // Method to set the state directly
  void setState(bool value) {
    state = value;
  }
}
