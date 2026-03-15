import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/features/wellness_packages/presentation/blocs/wellness_packages_bloc.dart';
import 'package:flutter_starter_kit/features/wellness_packages/presentation/blocs/wellness_packages_event.dart';
import 'package:flutter_starter_kit/shared/widgets/app_error_widget.dart';

class WellnessPackagesErrorView extends StatelessWidget {
  const WellnessPackagesErrorView({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return AppErrorWidget(
      message: message,
      onRetry: () => context
          .read<WellnessPackagesBloc>()
          .add(const WellnessPackagesLoadRequested()),
    );
  }
}
