import 'package:eventara/core/app_snackbar_widget.dart';
import 'package:eventara/providers/shared_preference_provider.dart';
import 'package:eventara/data/state/auth_state.dart';
import 'package:eventara/features/admin/admin_screen.dart';
import 'package:eventara/features/auth/sign_up_screen.dart';
import 'package:eventara/features/auth/widgets/auth_header.dart';
import 'package:eventara/features/auth/widgets/custom_text_field.dart';
import 'package:eventara/features/auth/widgets/primary_button.dart';
import 'package:eventara/features/auth/widgets/text_link.dart';
import 'package:eventara/main_screen.dart';
import 'package:eventara/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin(AuthProvider provider) {
    if (_formKey.currentState!.validate()) {
      provider.signIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, provider, _) {
          final state = provider.state;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (state is AuthError) {
              AppSnackBarWidget.showError(context, state.message);

              provider.resetState();
            } else if (state is AuthSuccess) {
              final sharedPrefProvider = Provider.of<SharedPreferenceProvider>(
                context,
                listen: false,
              );

              final userData = provider.userData;
              final userRole = userData?['role'] ?? 'user';

              sharedPrefProvider.login(
                userId: userData?['uid'] ?? '',
                email: userData?['email'] ?? '',
                userName: userData?['username'] ?? state.username,
                role: userRole,
              );

              if (userRole == 'Admin') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const AdminScreen()),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const MainScreen()),
                );
              }

              provider.resetState();
            }
          });

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                children: [
                  const AuthHeader(
                    title: "Masuk dan Jelajahi Event Seru!",
                    subtitle: "",
                    svgAsset: 'assets/vector/login.svg',
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          label: 'Email',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            if (!RegExp(
                              r'^[^@]+@[^@]+\.[^@]+',
                            ).hasMatch(value)) {
                              return 'Masukkan email yang valid';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: _passwordController,
                          label: 'Password',
                          icon: Icons.lock_outline,
                          obscureText: true,
                          validator: (value) =>
                              value != null && value.length < 6
                              ? 'Password minimal 6 karakter'
                              : null,
                        ),
                        const SizedBox(height: 24),
                        PrimaryButton(
                          text: "Masuk",
                          onPressed: () => _onLogin(provider),
                          isLoading: provider.isLoading,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextLink(
                    normalText: "Belum punya akun? ",
                    linkText: "Daftar sekarang",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignUpScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
