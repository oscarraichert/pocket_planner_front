import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pocket_planner_front/src/screens/transaction/transactions.screen.dart';
import 'package:pocket_planner_front/src/providers/transactions.provider.dart';
import 'package:pocket_planner_front/src/services/auth.service.dart';
import 'package:pocket_planner_front/src/sign_in_button.dart';
import 'package:provider/provider.dart';

import 'settings/settings_controller.dart';

import 'dart:developer';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          home: const HomePage(),
          routes: {
            '/transactions': (context) => ChangeNotifierProvider(create: (BuildContext context) => TransactionsProvider(), child: const TransactionsWidget()),
          },
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],
          onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
            appBarTheme: const AppBarTheme(color: Color.fromARGB(177, 255, 193, 7)),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(fontSize: 20),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            appBarTheme: const AppBarTheme(elevation: 10),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(fontSize: 20),
            ),
          ),
          themeMode: settingsController.themeMode,
        );
      },
    );
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildSignInButton(onPressed: () => handleSignIn()),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/transactions'),
              child: const Text('Transactions'),
            )
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

handleSignIn() async {
  var gsi = GoogleSignIn(serverClientId: GoogleConfig.clientId, scopes: GoogleConfig.scopes);

  await gsi.signIn().then((result) {
    result?.authentication.then((googleKey) async {
      if (googleKey.idToken != null) {
        await AuthService.storeAuthToken(googleKey.idToken!);
      }

      log('${googleKey.accessToken}');

      log('${googleKey.idToken}');
    }).catchError((err) {
      log(err);
    });
  }).catchError((err) {
    log(err);
  });
}

class GoogleConfig {
  static String clientId = '824653628296-ahr9jr3aqgr367mul4p359dj4plsl67a.apps.googleusercontent.com';
  static String iosClientId = '824653628296-5a4hseol33ep0vvo5tg29m39ib4src71.apps.googleusercontent.com';
  static String androidClientId = '824653628296-g4ij9785h9c1gkbimm5af42o4l7mket3.apps.googleusercontent.com';
  static List<String> scopes = ['email'];
}
