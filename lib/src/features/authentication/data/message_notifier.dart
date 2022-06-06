import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import '../domain/message.dart';

class MessageNotifier extends StateNotifier<List<Message>> {
  // We initialize the list of todos to an empty list
  MessageNotifier() : super([]);

  void addMessage(Message message) {
    // Since our state is immutable, we are not allowed to do `state.add(todo)`.
    // Instead, we should create a new list of todos which contains the previous
    // items and the new one.
    // Using Dart's spread operator here is helpful!
    state = [...state, message];
    // No need to call "notifyListeners" or anything similar. Calling "state ="
    // will automatically rebuild the UI when necessary.
  }

  // Let's allow removing todos
  void removeTodo(String messageId) {
    // Again, our state is immutable. So we're making a new list instead of
    // changing the existing list.
    state = [
      for (final message in state)
        if (message.id != messageId) message,
    ];
  }

  // Let's mark a todo as completed
  void toggle(String todoId) {
    state = [
      for (final message in state)
      // we're marking only the matching todo as completed
        if (message.id == todoId)
        // Once more, since our state is immutable, we need to make a copy
        // of the todo. We're using our `copyWith` method implemented before
        // to help with that.
          message.copyWith(completed: !message.completed)
        else
        // other todos are not modified
          message,
    ];
  }
}
// Finally, we are using StateNotifierProvider to allow the UI to interact with
// our TodosNotifier class.
final messageProvider = StateNotifierProvider<MessageNotifier, List<Message>>((ref) {
  return MessageNotifier();
});

