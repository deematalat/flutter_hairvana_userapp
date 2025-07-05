import 'package:flutter/material.dart';

class AuthToggleText extends StatelessWidget {
  final bool isLogin;
  final VoidCallback onTap;
  const AuthToggleText({required this.isLogin, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        isLogin ? "Don't have an account? Sign Up" : 'Already have an account? Log In',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
} 