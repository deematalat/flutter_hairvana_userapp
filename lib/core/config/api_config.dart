class ApiConfig {
  // This should be loaded from environment variables or secure storage
  // For development, you can set this in your environment
  static const String openAiKey = String.fromEnvironment(
    'OPENAI_API_KEY',
    defaultValue: 'your-api-key-here',
  );
  
  // Add other API configurations here
  static const String baseUrl = 'https://api.openai.com/v1';
} 