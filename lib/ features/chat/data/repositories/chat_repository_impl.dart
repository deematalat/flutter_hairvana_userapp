import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/repositories/chat_repository.dart';
import '../../presentation/models/chat_message.dart';
import '../../../../core/config/api_config.dart';

class ChatRepositoryImpl implements ChatRepository {
  @override
  Future<ChatMessage> sendMessage(String message, List<ChatMessage> conversationHistory) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ApiConfig.openAiKey}',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'system', 'content': 'You are a helpful AI hair style and cuts coach. Provide friendly, professional advice about hairstyles, cuts, and styling tips.'},
            ...conversationHistory.map((m) => {
              'role': m.isUser ? 'user' : 'assistant',
              'content': m.text,
            }),
            {'role': 'user', 'content': message},
          ],
          'max_tokens': 200,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final aiText = data['choices'][0]['message']['content'] as String? ?? 'Sorry, I could not understand.';
        return ChatMessage(text: aiText.trim(), isUser: false);
      } else {
        throw Exception('Failed to get response: ${response.statusCode}');
      }
    } catch (e) {
      return ChatMessage(
        text: 'Sorry, there was an error. Please try again.',
        isUser: false,
      );
    }
  }

  @override
  Future<List<ChatMessage>> getInitialMessages() async {
    return [
      ChatMessage(
        text: 'Hello! I am your AI Style Coach. How can I help you today?',
        isUser: false,
      ),
    ];
  }
} 