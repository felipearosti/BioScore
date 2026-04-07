import 'package:flutter/material.dart';

import 'auth_store.dart';
import 'register_screen.dart';

class AuthViewModel extends ChangeNotifier {
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  bool _isAuthenticating = false;

  bool get isAuthenticating => _isAuthenticating;

  String? validateCredentials({required String email, required String password}) {
    if (email.isEmpty || password.isEmpty) {
      return 'Preencha e-mail e senha para continuar.';
    }

    if (!_emailRegex.hasMatch(email)) {
      return 'Digite um e-mail em formato válido.';
    }

    return null;
  }

  Future<String?> authenticate({required String email, required String password}) async {
    _isAuthenticating = true;
    notifyListeners();

    await Future<void>.delayed(const Duration(milliseconds: 300));

    if (!AuthStore.instance.hasRegisteredUser) {
      _isAuthenticating = false;
      notifyListeners();
      return 'Nenhuma conta cadastrada. Crie seu cadastro primeiro.';
    }

    if (!AuthStore.instance.validateLogin(email: email, password: password)) {
      _isAuthenticating = false;
      notifyListeners();
      return 'E-mail ou senha inválidos.';
    }

    _isAuthenticating = false;
    notifyListeners();
    return null;
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authViewModel = AuthViewModel();

  bool _hidePassword = true;

  @override
  void initState() {
    super.initState();
    _authViewModel.addListener(_onAuthStateChanged);
  }

  void _onAuthStateChanged() {
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _authViewModel.removeListener(_onAuthStateChanged);
    _emailController.dispose();
    _passwordController.dispose();
    _authViewModel.dispose();
    super.dispose();
  }

  void _showFeedback({required String message, required bool isError}) {
    final color = isError ? Colors.red.shade700 : Colors.green.shade700;

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final validationError = _authViewModel.validateCredentials(
      email: email,
      password: password,
    );

    if (validationError != null) {
      _showFeedback(message: validationError, isError: true);
      return;
    }

    FocusScope.of(context).unfocus();

    final authError = await _authViewModel.authenticate(
      email: email,
      password: password,
    );
    if (!mounted) {
      return;
    }

    if (authError != null) {
      _showFeedback(message: authError, isError: true);
      return;
    }

    _showFeedback(
      message: 'Login validado com sucesso!',
      isError: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight - 48),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            width: 92,
                            height: 92,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: colorScheme.primary.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: colorScheme.primary.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Icon(
                              Icons.monitor_heart_outlined,
                              color: colorScheme.primary,
                              size: 44,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'BioScore',
                            textAlign: TextAlign.center,
                            style: textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Gestão inteligente de emagrecimento',
                            textAlign: TextAlign.center,
                            style: textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF6B7280),
                            ),
                          ),
                          const SizedBox(height: 32),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'E-mail',
                              prefixIcon: Icon(Icons.mail_outline_rounded),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _hidePassword,
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              prefixIcon: const Icon(Icons.lock_outline_rounded),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() => _hidePassword = !_hidePassword);
                                },
                                icon: Icon(
                                  _hidePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text('Esqueceu a senha?'),
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: _authViewModel.isAuthenticating ? null : _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                            ),
                            child: Text(
                              _authViewModel.isAuthenticating
                                  ? 'Validando...'
                                  : 'Entrar',
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text('Cadastro de Usuário'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
