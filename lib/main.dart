import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/app/models/episode_model.dart';
import 'package:rick_morty_app/app/viewmodel/episode_character_viewmodel.dart';
import 'package:rick_morty_app/app/viewmodel/episode_viewmodel.dart';
import 'package:rick_morty_app/app/viewmodel/favourites_viewmodel.dart';
import 'package:rick_morty_app/core/theme.dart';

import 'app/locator.dart';
import 'app/router.dart';
import 'app/viewmodel/character_profile_viewmodel.dart';
import 'app/viewmodel/characters_viewmodel.dart';
import 'app/viewmodel/location_viewmodel.dart';
import 'app/viewmodel/resident_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CharactersViewModel()),
        ChangeNotifierProvider(create: (context) => FavouritesViewModel()),
        ChangeNotifierProvider(
            create: (context) => CharacterProfileViewmodel()),
        ChangeNotifierProvider(create: (context) => LocationViewModel()),
        ChangeNotifierProvider(create: (context) => ResidentViewModel()),
        ChangeNotifierProvider(create: (context) => EpisodeViewModel()),
        ChangeNotifierProvider(
            create: (context) => EpisodeCharacterViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.lightTheme,
    );
  }
}
