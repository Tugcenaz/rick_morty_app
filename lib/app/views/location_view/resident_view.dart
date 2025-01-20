import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/app/components/appbar_widget.dart';
import 'package:rick_morty_app/app/components/character_card_widget.dart';
import 'package:rick_morty_app/app/viewmodel/favourites_viewmodel.dart';
import 'package:rick_morty_app/app/viewmodel/resident_viewmodel.dart';

import '../../models/character_model.dart';
import '../../models/location_model.dart';

class ResidentView extends StatefulWidget {
  Locations location;

  ResidentView({super.key, required this.location});

  @override
  State<ResidentView> createState() => _ResidentViewState();
}

class _ResidentViewState extends State<ResidentView> {
  @override
  void initState() {
    super.initState();
    context.read<ResidentViewModel>().getResidents(widget.location.residents!);
  }

  @override
  Widget build(BuildContext context) {
    final favViewModel = context.watch<FavouritesViewModel>();
    return Scaffold(
      appBar: AppbarWidget(title: widget.location.name ?? 'Location'),
      body: Consumer<ResidentViewModel>(builder: (context, viewModel, child) {
        final List<Character>? characterList = viewModel.residentCharacters;
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: characterList == null
              ? const Center(child: Text("Bu konum için hiç karakter yok"))
              : ListView.builder(
                  itemCount: characterList?.length,
                  itemBuilder: (context, index) {
                    Character character = viewModel.residentCharacters![index];
                    bool isFavorited =
                        favViewModel.savedCharacters.contains(character.id);
                    return CharacterCardWidget(
                      character: character,
                      isFavourite: isFavorited,
                    );
                  }),
        );
      }),
    );
  }
}
