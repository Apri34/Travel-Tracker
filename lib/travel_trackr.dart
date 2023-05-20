import 'package:flutter/material.dart';

import 'core/l10n/generated/l10n.dart';
import 'core/navigation/app_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/theme/app_theme.dart';

class TravelTrackr extends StatelessWidget {
  final _appRouter = AppRouter();

  TravelTrackr({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      builder: (context, child) {
        return Theme(
          data: AppTheme.theme,
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: child!,
          ),
        );
      },
      debugShowCheckedModeBanner: false,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
    );
  }
}
