import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/app/components/appbar_widget.dart';
import 'package:rick_morty_app/app/models/episode_model.dart';
import 'package:rick_morty_app/app/viewmodel/episode_character_viewmodel.dart';

import '../components/character_card_widget.dart';
import '../models/character_model.dart';
import '../viewmodel/favourites_viewmodel.dart';

class EpisodeCharacters extends StatefulWidget {
  Episode episode;

  EpisodeCharacters({super.key, required this.episode});

  @override
  State<EpisodeCharacters> createState() => _EpisodeCharactersState();
}

class _EpisodeCharactersState extends State<EpisodeCharacters> {
  @override
  void initState() {
    context
        .read<EpisodeCharacterViewModel>()
        .getEpisodeCharacters(widget.episode.characters!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favouriteViewModel = context.watch<FavouritesViewModel>();
    return Scaffold(
      appBar: AppbarWidget(title: widget.episode.name ?? ''),
      body: Consumer<EpisodeCharacterViewModel>(
        builder: (context, viewModel, child) {
          final List<Character>? characterList = viewModel.characterList;
          return characterList == null
              ? const Center(
                  child: Text("Bu bölüm için karakter bulunamadı"),
                )
              : Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListView.builder(
                    itemCount: characterList.length,
                    itemBuilder: (context, index) {
                      bool isFavourited = favouriteViewModel.savedCharacters
                          .contains(characterList[index].id);
                      return CharacterCardWidget(
                        character: characterList[index],
                        isFavourite: isFavourited,
                      );
                    }),
              );
        },
      ),
    );
  }
}
