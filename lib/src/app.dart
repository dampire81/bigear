import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/authentication/data/message_notifier.dart';
import 'features/authentication/data/stomp_repository.dart';
import 'features/authentication/presentation/message_screen.dart';

class MyApp extends ConsumerWidget {

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final StompRepository stompRepository = StompRepository();
    stompRepository.setWidgetRef(ref);
    stompRepository.activate();

    return MaterialApp(
      title: 'BigEar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home:  const Scaffold(
        body: MessageScreen(),
      ),
    );
  }


}
