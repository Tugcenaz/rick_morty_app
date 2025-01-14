import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/app/components/character_card_widget.dart';
import 'package:rick_morty_app/app/viewmodel/favourites_viewmodel.dart';

class FavouritesView extends StatefulWidget {
  FavouritesView({super.key});

  bool favourite = true;

  @override
  State<FavouritesView> createState() => _FavouritesViewState();
}

class _FavouritesViewState extends State<FavouritesView> {
  @override
  void initState() {
    print("init state");
    context.read<FavouritesViewModel>().getFavourites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouritesViewModel>(
      builder:
          (BuildContext context, FavouritesViewModel value, Widget? child) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: value.favourites.isEmpty
                ? const Center(child: Text("Henüz favorileriniz boş"))
                : ListView.builder(
                    itemCount: value.favourites.length,
                    itemBuilder: (context, index) {
                      return CharacterCardWidget(
                        /*isFavourite: value.favourites[index].isFavourite,
                        character: value.favourites[index].character,*/
                        favouriteCharacterModel: value.favourites[index],
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
