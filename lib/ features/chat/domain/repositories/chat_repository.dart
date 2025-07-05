import '../../presentation/models/chat_message.dart';

abstract class ChatRepository {
  Future<ChatMessage> sendMessage(String message, List<ChatMessage> conversationHistory);
  Future<List<ChatMessage>> getInitialMessages();
} 