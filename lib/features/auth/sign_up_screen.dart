import 'package:eventara/data/state/auth_state.dart';
import 'package:eventara/features/auth/sign_in_screen.dart';
import 'package:eventara/main_screen.dart';
import 'package:eventara/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final Color primaryColor = const Color(0xFF0096C7);
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
          const SnackBar(content: Text('Silakan pilih role terlebih dahulu')),
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              Text(
                "Eventara",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 24),
              SvgPicture.asset(
                'assets/vector/register.svg',
                width: 240,
                height: 240,
              ),
              const SizedBox(height: 32),
              const Text(
                "Buat Akunmu dan Jelajahi Event Menarik!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              Consumer<AuthProvider>(
                builder: (context, authProvider, _) {
                  final state = authProvider.state;

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (state is AuthError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                      authProvider.resetState();
                    } else if (state is AuthSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Akun berhasil dibuat! Selamat datang ${state.username}',
                          ),
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const MainScreen()),
                      );
                    }
                  });

                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: _nameController,
                          label: 'Nama Lengkap',
                          icon: Icons.person_outline,
                          validator: (v) =>
                              v!.isEmpty ? 'Nama tidak boleh kosong' : null,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          controller: _emailController,
                          label: 'Email',
                          icon: Icons.email_outlined,
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
                        _buildTextField(
                          controller: _passwordController,
                          label: 'Password',
                          icon: Icons.lock_outline,
                          obscure: true,
                          validator: (v) => v!.length < 6
                              ? 'Password minimal 6 karakter'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: selectedRole,
                          decoration: InputDecoration(
                            labelText: 'Pilih Role',
                            prefixIcon: Icon(
                              Icons.work_outline,
                              color: primaryColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          items: roles
                              .map(
                                (role) => DropdownMenuItem(
                                  value: role,
                                  child: Text(role),
                                ),
                              )
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedRole = value),
                          validator: (v) =>
                              v == null ? 'Pilih role terlebih dahulu' : null,
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: authProvider.isLoading
                                ? null
                                : () => _onRegister(authProvider),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 3,
                            ),
                            child: authProvider.isLoading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    "Daftar",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Text.rich(
                TextSpan(
                  text: "Sudah punya akun? ",
                  children: [
                    TextSpan(
                      text: "Masuk di sini",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignInScreen(),
                          ),
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        prefixIcon: Icon(icon, color: primaryColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: validator,
    );
  }
}
