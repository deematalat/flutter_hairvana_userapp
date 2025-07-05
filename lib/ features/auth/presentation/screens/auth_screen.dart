import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/input_field.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_toggle_text.dart';
import '../widgets/auth_error_message.dart';
import '../../../../main.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _navigateToMain(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainNavigation()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.success) {
            // Only navigate on successful authentication
            _navigateToMain(context);
          }
        },
        builder: (context, state) {
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
                        state.isLogin ? 'Welcome Back!' : 'Join Hairvana',
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: size.height * 0.05),
                      InputField(
                        controller: _emailController,
                        hintText: 'Email',
                        icon: FontAwesomeIcons.solidEnvelope,
                        fontSize: fieldFontSize,
                        borderRadius: borderRadius,
                        padding: fieldPadding,
                        obscureText: false,
                        suffixIcon: null,
                        onChanged: (value) => context.read<AuthBloc>().add(AuthEmailChanged(value)),
                      ),
                      SizedBox(height: size.height * 0.025),
                      InputField(
                        controller: _passwordController,
                        hintText: 'Password',
                        icon: FontAwesomeIcons.lock,
                        fontSize: fieldFontSize,
                        borderRadius: borderRadius,
                        padding: fieldPadding,
                        obscureText: !state.showPassword,
                        suffixIcon: IconButton(
                          icon: Icon(state.showPassword ? Icons.visibility : Icons.visibility_off, color: Colors.grey[700]),
                          onPressed: () => context.read<AuthBloc>().add(AuthTogglePasswordVisibility()),
                        ),
                        onChanged: (value) => context.read<AuthBloc>().add(AuthPasswordChanged(value)),
                      ),
                      if (!state.isLogin) ...[
                        SizedBox(height: size.height * 0.025),
                        InputField(
                          controller: _confirmPasswordController,
                          hintText: 'Confirm Password',
                          icon: FontAwesomeIcons.lock,
                          fontSize: fieldFontSize,
                          borderRadius: borderRadius,
                          padding: fieldPadding,
                          obscureText: !state.showConfirmPassword,
                          suffixIcon: IconButton(
                            icon: Icon(state.showConfirmPassword ? Icons.visibility : Icons.visibility_off, color: Colors.grey[700]),
                            onPressed: () => context.read<AuthBloc>().add(AuthToggleConfirmPasswordVisibility()),
                          ),
                          onChanged: (value) => context.read<AuthBloc>().add(AuthConfirmPasswordChanged(value)),
                        ),
                      ],
                      AuthErrorMessage(error: state.error),
                      SizedBox(height: size.height * 0.045),
                      AuthButton(
                        isLogin: state.isLogin,
                        isLoading: state.isLoading,
                        fontSize: buttonFontSize,
                        onPressed: () => context.read<AuthBloc>().add(AuthSubmitted()),
                      ),
                      SizedBox(height: size.height * 0.03),
                      AuthToggleText(
                        isLogin: state.isLogin,
                        onTap: () => context.read<AuthBloc>().add(AuthToggleMode()),
                      ),
                      SizedBox(height: size.height * 0.08),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
