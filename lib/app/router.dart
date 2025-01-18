import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/app/components/character_card_widget.dart';
import 'package:rick_morty_app/app/viewmodel/character_profile_viewmodel.dart';
import 'package:rick_morty_app/app/views/app_view.dart';
import 'package:rick_morty_app/app/views/character_profile_view/character_profile_view.dart';

import 'models/character_model.dart';
import 'views/characters_view.dart';
import 'views/episodes_view.dart';
import 'views/favourites_view.dart';
import 'views/locations_view.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  AppRoutes._();

  static const String charactersView = "/";
  static const String locationsView = "/locations";
  static const String episodesView = "/episodes";
  static const String favouritesView = "/favourites";
  static const String characterProfile = "/character-profile";
  static const String profileRoutes = "character-profile";
}

final router = GoRouter(
  navigatorKey: _navigatorKey,
  initialLocation: AppRoutes.charactersView,
  routes: [
    StatefulShellRoute.indexedStack(
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.charactersView,
              builder: (context, state) => const CharactersView(),
              routes: [
                GoRoute(
                    onExit: (BuildContext context, GoRouterState state) {
                      context.read<CharacterProfileViewmodel>().clearEpisodes();
                      return true;
                    },
                    path: AppRoutes.profileRoutes,
                    builder: (context, state) => CharacterProfileView(
                          character: state.extra as Character,
                        )),
              ],
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.favouritesView,
              builder: (context, state) => const FavouritesView(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.locationsView,
                builder: (context, state) => const LocationsView()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.episodesView,
                builder: (context, state) => const EpisodesView()),
          ]),
        ],
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationState) {
          return AppView(navigationShell: navigationState);
        })
  ],
);
