import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatMessageSent extends ChatEvent {
  final String message;
  ChatMessageSent(this.message);
  @override
  List<Object?> get props => [message];
}

class ChatLoadMessages extends ChatEvent {}

class ChatClearMessages extends ChatEvent {} 