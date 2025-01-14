import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../components/appbar_widget.dart';

class AppView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppView({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      //hepsinde aynı appbar olsun istemezsem bunu silip diğer her sayfaya appbar eklicem
      body: navigationShell,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateTextStyle.resolveWith(
            (state) {
              if (state.contains(WidgetState.selected)) {
                return TextStyle(color: Theme.of(context).colorScheme.primary);
              }
              return TextStyle(color: Theme.of(context).colorScheme.tertiary);
            },
          ),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) => navigationShell.goBranch(index),
          indicatorColor: Colors.transparent,
          destinations: [
            _menuItem(
                context: context,
                title: "Karakterler",
                icon: Icons.face,
                index: 0,
                currentIndex: navigationShell.currentIndex),
            _menuItem(
                context: context,
                title: "Favorilerim",
                icon: Icons.bookmark,
                index: 1,
                currentIndex: navigationShell.currentIndex),
            _menuItem(
                context: context,
                title: "Konumlar",
                icon: Icons.location_on,
                index: 2,
                currentIndex: navigationShell.currentIndex),
            _menuItem(
                context: context,
                title: "Bölümler",
                icon: Icons.menu,
                index: 3,
                currentIndex: navigationShell.currentIndex),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(
      {required String title,
      required IconData icon,
      required int index,
      required int currentIndex,
      required BuildContext context}) {
    return NavigationDestination(
      icon: Icon(
        icon,
        color: currentIndex == index
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.tertiary,
      ),
      label: title,
    );
  }

  AppBar buildAppBar() {
    return appBar(
      title: 'Rick and Morty',
      actions: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.settings,
        ),
      ),
    );
  }
}
