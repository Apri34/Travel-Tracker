import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../di/injection.dart';

abstract class AppCubitScreen<Bloc extends BlocBase<State>, State>
    extends StatelessWidget {
  const AppCubitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<Bloc>(),
      child: _AppCubitScreenBody<Bloc, State>(
        b: builder,
        listener: listener,
      ),
    );
  }

  Widget builder(BuildContext context);

  void listener(BuildContext context, State state) {}
}

class _AppCubitScreenBody<Bloc extends BlocBase<State>, State>
    extends StatelessWidget {
  final Widget Function(BuildContext context) b;
  final void Function(BuildContext context, State state) listener;

  const _AppCubitScreenBody({
    super.key,
    required this.b,
    required this.listener,
  });

  @override
  Widget build(BuildContext context) => BlocListener<Bloc, State>(
        listener: listener,
        child: b(context),
      );
}
