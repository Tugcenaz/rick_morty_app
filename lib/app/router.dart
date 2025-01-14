import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_app/app/views/app_view.dart';

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
                builder: (context, state) => const CharactersView()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.favouritesView,
                builder: (context, state) =>  FavouritesView()),
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
