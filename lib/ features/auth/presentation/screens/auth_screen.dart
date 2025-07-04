import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../main.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _authService = GetIt.instance<AuthService>();

  bool isLogin = true;
  bool showPassword = false;
  bool showConfirmPassword = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;
  String? error;

  Future<void> _handleAuth() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      bool success = false;

      if (isLogin) {
        success = await _authService.login(email, password);
      } else {
        if (password != confirm) {
          setState(() {
            error = "Passwords do not match.";
            isLoading = false;
          });
          return;
        }
        success = await _authService.signUp(email, password);
      }

      if (success) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainNavigation()),
        );
      } else {
        setState(() => error = "Authentication failed.");
      }
    } catch (e) {
      setState(() => error = "An error occurred.");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fieldFontSize = size.width * 0.045 > 20 ? 20.0 : size.width * 0.045;
    final buttonFontSize = size.width * 0.055 > 22 ? 22.0 : size.width * 0.055;
    final borderRadius = BorderRadius.circular(14);
    final fieldPadding = EdgeInsets.symmetric(horizontal: 18, vertical: size.height * 0.022);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.08),
                Text(
                  isLogin ? 'Welcome Back!' : 'Join Hairvana',
                  style: AppTextStyles.largeTitle(),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height * 0.05),
                _InputField(
                  controller: emailController,
                  hintText: 'Email',
                  icon: FontAwesomeIcons.solidEnvelope,
                  fontSize: fieldFontSize,
                  borderRadius: borderRadius,
                  padding: fieldPadding,
                ),
                SizedBox(height: size.height * 0.025),
                _InputField(
                  controller: passwordController,
                  hintText: 'Password',
                  icon: FontAwesomeIcons.lock,
                  fontSize: fieldFontSize,
                  borderRadius: borderRadius,
                  padding: fieldPadding,
                  obscureText: !showPassword,
                  suffixIcon: IconButton(
                    icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off, color: Colors.grey[700]),
                    onPressed: () => setState(() => showPassword = !showPassword),
                  ),
                ),
                if (!isLogin) ...[
                  SizedBox(height: size.height * 0.025),
                  _InputField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    icon: FontAwesomeIcons.lock,
                    fontSize: fieldFontSize,
                    borderRadius: borderRadius,
                    padding: fieldPadding,
                    obscureText: !showConfirmPassword,
                    suffixIcon: IconButton(
                      icon: Icon(showConfirmPassword ? Icons.visibility : Icons.visibility_off, color: Colors.grey[700]),
                      onPressed: () => setState(() => showConfirmPassword = !showConfirmPassword),
                    ),
                  ),
                ],
                if (error != null) ...[
                  SizedBox(height: size.height * 0.02),
                  Text(error!, style: AppTextStyles.body().copyWith(color: Colors.red)),
                ],
                SizedBox(height: size.height * 0.045),
                GestureDetector(
                  onTap: isLoading ? null : _handleAuth,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.025),
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
                            size: buttonFontSize + 2,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            isLogin ? 'Log In' : 'Sign Up',
                            style: AppTextStyles.button(
                              fontSize: buttonFontSize,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                GestureDetector(
                  onTap: () => setState(() {
                    isLogin = !isLogin;
                    error = null;
                  }),
                  child: Text(
                    isLogin ? "Don't have an account? Sign Up" : 'Already have an account? Log In',
                    style: AppTextStyles.body(),
                  ),
                ),
                SizedBox(height: size.height * 0.08),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final double fontSize;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final bool obscureText;
  final Widget? suffixIcon;

  const _InputField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.fontSize,
    required this.borderRadius,
    required this.padding,
    this.obscureText = false,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: borderRadius,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: FaIcon(icon, color: Colors.grey[700], size: fontSize + 2),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: fontSize, color: Colors.grey[600]),
                contentPadding: padding,
                suffixIcon: suffixIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
