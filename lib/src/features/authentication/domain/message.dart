import 'package:flutter/cupertino.dart';

// The state of our StateNotifier should be immutable.
// We could also use packages like Freezed to help with the implementation.import 'package:flutter/cupertino.dart';
@immutable
class Message {
  const Message({required this.id, required this.completed, required this.user, required this.text, required this.timestamp});

  // All properties should be `final` on our class.
  final String id;
  final String user;
  final String text;
  final String timestamp;
  final bool completed;

  // Since Todo is immutable, we implement a method that allows cloning the
  // Todo with slightly different content.
  Message copyWith({String? id, bool? completed, String? user, String? text, String? timestamp}) {
    return Message(
      id: id ?? this.id,
      completed: completed ?? this.completed,
      user: user ?? this.user,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}