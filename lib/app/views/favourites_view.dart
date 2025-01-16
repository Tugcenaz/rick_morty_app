import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/app/components/character_card_widget.dart';
import 'package:rick_morty_app/app/viewmodel/favourites_viewmodel.dart';

import '../models/character_model.dart';

class FavouritesView extends StatefulWidget {
  const FavouritesView({super.key});

  @override
  State<FavouritesView> createState() => _FavouritesViewState();
}

class _FavouritesViewState extends State<FavouritesView> {
  @override
  void initState() {
    super.initState();
    context.read<FavouritesViewModel>().getSavedCharacter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FavouritesViewModel>(builder: (context, viewModel, child) {
        return viewModel.favouriteCharacters == null
            ? const Center(
                child: Text("Henüz bir karakter favorilemediniz"),
              )
            : ListView.builder(
                itemCount: viewModel.favouriteCharacters!.length,
                itemBuilder: (context, index) {
                  return CharacterCardWidget(
                      character: viewModel.favouriteCharacters![index],
                      isFavourite: true);
                });
      }),
    );
  }
}
