//@formatter:off

import 'package:cache_storage_demo/app/localization/generated/l10n.dart';
import 'package:cache_storage_demo/app/router/app_router.dart';
import 'package:cache_storage_demo/core/arch/widget/common/theme_switcher.dart';
import 'package:cache_storage_demo/presentation/style/theme/theme_imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Locale? locale;

  @override
  Widget build(BuildContext context) {
    AppRouter.init();
    return GlobalLoaderOverlay(
      overlayColor: Colors.black.withOpacity(0.5),
      child: ThemeModeSwitcher(
        builder: (context, themeMode, _) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.noScaling),
                child: widget ?? const SizedBox(),
              );
            },
            scrollBehavior: const CupertinoScrollBehavior(),
            theme: createLightTheme(),
            darkTheme: createDarkTheme(),
            themeMode: themeMode,
            routerConfig: AppRouter.router,
            locale: locale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            onGenerateTitle: (context) => S.of(context).title,
          );
        },
      ),
    );
  }
}
