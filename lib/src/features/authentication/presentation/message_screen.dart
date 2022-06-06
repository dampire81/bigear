import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/message.dart';
import '../data/message_notifier.dart';

class MessageScreen extends ConsumerWidget {
  const MessageScreen({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // rebuild the widget when the todo list changes
    List<Message> messages = ref.watch(messageProvider);
    // Let's render the todos in a scrollable list view
    return ListView(
      children: [
        for (final message in messages)
          CheckboxListTile(
            value: false,
            // When tapping on the todo, change its completed status
            onChanged: (value) => ref.read(messageProvider.notifier).removeTodo(message.id),
            title: Text(message.text),
          ),
      ],
    );
  }
}