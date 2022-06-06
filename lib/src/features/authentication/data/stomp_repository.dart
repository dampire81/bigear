import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../domain/message.dart';
import 'message_notifier.dart';

late WidgetRef widgetRef;

class StompRepository  {

  Future<void> activate() async {
    stompClient.activate();
  }
  Future<void> deactivate() async {
    stompClient.deactivate();
  }
  void setWidgetRef(WidgetRef ref){
    widgetRef = ref;
  }
  WidgetRef getWidgetRef(){
    return widgetRef;
  }

}

void onConnect(StompFrame frame) {
  stompClient.subscribe(
    destination: '/user/topic/message', //specifico utente
    // destination: '/topic/news', //broadcast
    callback: (frame) {
      // Map<String, dynamic> map = json.decode(frame.body!);
      // List<dynamic> data = map["dataKey"];
      print('ricevo messaggio fuori');
      print(frame.body!);
      Message message = Message(id: '1', completed: false, user: '', text: frame.body!, timestamp: '');

      widgetRef.read(messageProvider.notifier).addMessage(message);
      // List<dynamic>? result = json.decode(frame.body!);
      // print(result);
    },
  );
}

final stompClient = StompClient(
  config: StompConfig.SockJS(
    url: 'http://10.0.2.2:8080/server-sent-events-spring/websockets',
    // url: 'ws://localhost:8080',
    onConnect: onConnect,
    beforeConnect: () async {
      print('waiting to connect...');
      await Future.delayed(Duration(milliseconds: 200));
      print('connecting...');
    },
    onWebSocketError: (dynamic error) => print(error.toString()),
    stompConnectHeaders: {'Authorization': 'Bearer yourToken', 'login': 'pluto'},
    webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
  ),
);