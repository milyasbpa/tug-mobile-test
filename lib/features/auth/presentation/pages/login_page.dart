import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/core/l10n/translations.g.dart';
import 'package:flutter_starter_kit/core/router/route_names.dart';
import 'package:flutter_starter_kit/core/theme/app_spacing.dart';
import 'package:flutter_starter_kit/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:flutter_starter_kit/features/auth/presentation/blocs/auth_event.dart';
import 'package:flutter_starter_kit/features/auth/presentation/blocs/auth_state.dart';
import 'package:flutter_starter_kit/shared/widgets/app_button.dart';
import 'package:flutter_starter_kit/shared/widgets/app_snack_bar.dart';
import 'package:flutter_starter_kit/shared/widgets/app_text_field.dart';
import 'package:go_router/go_router.dart';

/// Login screen backed by [AuthBloc].
///
/// Pre-filled with mock-friendly credentials for easy starter kit demo.
/// Remove the pre-fill and [_TestCredentialsHint] when integrating a real API.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController(text: 'user@example.com');
  final _passwordController = TextEditingController(text: 'password123');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (email.isEmpty) {
      AppSnackBar.show(
        context,
        context.t.auth.validation.emailRequired,
        type: AppSnackBarType.warning,
      );
      return;
    }
    if (password.isEmpty) {
      AppSnackBar.show(
        context,
        context.t.auth.validation.passwordRequired,
        type: AppSnackBarType.warning,
      );
      return;
    }
    context.read<AuthBloc>().add(
          AuthLoginRequested(email: email, password: password),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go(RouteNames.home);
        } else if (state is AuthError) {
          AppSnackBar.show(
            context,
            state.message,
            type: AppSnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Scaffold(
          appBar: AppBar(title: Text(context.t.auth.loginTitle)),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacing.xl),
                  AppTextField(
                    controller: _emailController,
                    label: context.t.auth.emailLabel,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    controller: _passwordController,
                    label: context.t.auth.passwordLabel,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _submit(),
                    prefixIcon: const Icon(Icons.lock_outlined),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppButton(
                    label: context.t.auth.loginButton,
                    isLoading: isLoading,
                    isFullWidth: true,
                    onPressed: _submit,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AppButton(
                    label:
                        '${context.t.auth.dontHaveAccount} ${context.t.auth.registerLink}',
                    variant: AppButtonVariant.text,
                    onPressed: isLoading
                        ? null
                        : () => context.go(RouteNames.register),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const _TestCredentialsHint(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TestCredentialsHint extends StatelessWidget {
  const _TestCredentialsHint();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dev mock — any email + any password works',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: 4),
            Text(
              'Use password "wrong" to trigger an error state.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
