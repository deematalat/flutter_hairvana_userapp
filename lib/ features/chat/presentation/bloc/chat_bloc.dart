import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_event.dart';
import 'chat_state.dart';
import '../../domain/repositories/chat_repository.dart';
import '../models/chat_message.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository repository;

  ChatBloc({required this.repository}) : super(const ChatState()) {
    on<ChatLoadMessages>(_onLoadMessages);
    on<ChatMessageSent>(_onMessageSent);
    on<ChatClearMessages>(_onClearMessages);
  }

  void _onLoadMessages(ChatLoadMessages event, Emitter<ChatState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final messages = await repository.getInitialMessages();
      emit(state.copyWith(messages: messages, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to load messages',
        isLoading: false,
      ));
    }
  }

  void _onMessageSent(ChatMessageSent event, Emitter<ChatState> emit) async {
    if (event.message.trim().isEmpty) return;

    // Add user message immediately
    final userMessage = ChatMessage(text: event.message, isUser: true);
    final updatedMessages = [...state.messages, userMessage];
    emit(state.copyWith(messages: updatedMessages, isLoading: true, error: null));

    try {
      // Get AI response
      final aiMessage = await repository.sendMessage(event.message, state.messages);
      final finalMessages = [...updatedMessages, aiMessage];
      emit(state.copyWith(messages: finalMessages, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        messages: updatedMessages,
        isLoading: false,
        error: 'Failed to send message',
      ));
    }
  }

  void _onClearMessages(ChatClearMessages event, Emitter<ChatState> emit) {
    emit(const ChatState());
  }
} 