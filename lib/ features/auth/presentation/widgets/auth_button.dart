import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthButton extends StatelessWidget {
  final bool isLogin;
  final bool isLoading;
  final double fontSize;
  final VoidCallback? onPressed;
  const AuthButton({
    required this.isLogin,
    required this.isLoading,
    required this.fontSize,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.025),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [Color(0xFFa78bfa), Color(0xFFf472b6), Color(0xFFfb7185)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.10),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      isLogin ? FontAwesomeIcons.arrowRightToBracket : FontAwesomeIcons.userPlus,
                      color: Colors.white,
                      size: fontSize + 2,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      isLogin ? 'Log In' : 'Sign Up',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
} 