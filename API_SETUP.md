# API Key Setup Guide

## OpenAI API Key Configuration

To use the AI chat feature, you need to set up your OpenAI API key securely.

### Method 1: Environment Variables (Recommended)

1. Create a `.env` file in your project root:
```
OPENAI_API_KEY=your_actual_openai_api_key_here
```

2. Add `.env` to your `.gitignore` file to prevent it from being committed to version control:
```
# Environment files
.env
.env.local
.env.production
```

3. Update the `ApiConfig` class to load from environment:
```dart
// In lib/core/config/api_config.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String get openAiKey => dotenv.env['OPENAI_API_KEY'] ?? 'your-api-key-here';
}
```

### Method 2: Build-time Configuration

Run your app with the API key as a build argument:

```bash
flutter run --dart-define=OPENAI_API_KEY=your_actual_openai_api_key_here
```

### Method 3: Secure Storage (Production)

For production apps, consider using secure storage solutions like:
- `flutter_secure_storage` for mobile
- Encrypted shared preferences
- Key management services

## Getting an OpenAI API Key

1. Go to [OpenAI Platform](https://platform.openai.com/)
2. Sign up or log in to your account
3. Navigate to API Keys section
4. Create a new API key
5. Copy the key and use it in your configuration

## Security Best Practices

- Never commit API keys to version control
- Use environment variables or secure storage
- Rotate API keys regularly
- Monitor API usage to control costs
- Use API key restrictions when possible

## Testing

The chat feature includes error handling and will show appropriate messages if:
- API key is missing or invalid
- Network connection fails
- API rate limits are exceeded 