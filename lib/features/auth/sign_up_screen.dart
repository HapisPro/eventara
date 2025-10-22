import 'package:eventara/core/styles/app_color.dart';
import 'package:eventara/data/state/auth_state.dart';
import 'package:eventara/features/auth/sign_in_screen.dart';
import 'package:eventara/features/auth/widgets/auth_header.dart';
import 'package:eventara/features/auth/widgets/custom_text_field.dart';
import 'package:eventara/features/auth/widgets/primary_button.dart';
import 'package:eventara/features/auth/widgets/text_link.dart';
import 'package:eventara/main_screen.dart';
import 'package:eventara/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? selectedRole;
  final List<String> roles = ['Admin', 'Explorer'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegister(AuthProvider provider) {
    if (_formKey.currentState!.validate()) {
      if (selectedRole == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Silakan pilih role terlebih dahulu'),
            backgroundColor: AppColor.error.color,
          ),
        );
        return;
      }

      provider.signUp(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
        selectedRole!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              const AuthHeader(
                title: "Buat Akunmu dan Jelajahi Event Menarik!",
                subtitle: "",
                svgAsset: 'assets/vector/register.svg',
              ),
              Consumer<AuthProvider>(
                builder: (context, authProvider, _) {
                  final state = authProvider.state;

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: AppColor.error.color,
                        ),
                      );
                      authProvider.resetState();
                    } else if (state is AuthSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Akun berhasil dibuat! Selamat datang ${state.username}',
                          ),
                          backgroundColor: AppColor.success.color,
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const MainScreen()),
                      );
                      authProvider.resetState();
                    }
                  });

                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _nameController,
                          label: 'Nama Lengkap',
                          icon: Icons.person_outline,
                          validator: (v) =>
                              v!.isEmpty ? 'Nama tidak boleh kosong' : null,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: _emailController,
                          label: 'Email',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Email wajib diisi';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                              return 'Format email tidak valid';
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
                          validator: (v) => v!.length < 6
                              ? 'Password minimal 6 karakter'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: selectedRole,
                          dropdownColor: theme.colorScheme.surface,
                          decoration: InputDecoration(
                            labelText: 'Pilih Role',
                            prefixIcon: Icon(
                              Icons.work_outline,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          items: roles
                              .map(
                                (role) => DropdownMenuItem(
                                  value: role,
                                  child: Text(
                                    role,
                                    style: TextStyle(
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedRole = value),
                          validator: (v) =>
                              v == null ? 'Pilih role terlebih dahulu' : null,
                        ),
                        const SizedBox(height: 24),
                        PrimaryButton(
                          text: "Daftar",
                          onPressed: () => _onRegister(authProvider),
                          isLoading: authProvider.isLoading,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              TextLink(
                normalText: "Sudah punya akun? ",
                linkText: "Masuk di sini",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignInScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
