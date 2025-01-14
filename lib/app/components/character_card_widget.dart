import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/app/models/character_model.dart';
import 'package:rick_morty_app/app/models/favourite_character_model.dart';

import '../viewmodel/favourites_viewmodel.dart';

class CharacterCardWidget extends StatefulWidget {
  //Character character;

  // bool isFavourite;

  FavouriteCharacterModel favouriteCharacterModel;

  CharacterCardWidget(
      {super.key,
      //required this.character,
      // required this.isFavourite
      required this.favouriteCharacterModel});

  @override
  State<CharacterCardWidget> createState() => _CharacterCardWidgetState();
}

class _CharacterCardWidgetState extends State<CharacterCardWidget> {
  void toggleFavourite() {
    final viewModel = context.read<FavouritesViewModel>();
    if (widget.favouriteCharacterModel.isFavourite) {
      viewModel.removeFavouriteCharacter(
          id: widget.favouriteCharacterModel.character.id!);
      widget.favouriteCharacterModel.isFavourite = false;
    } else {
      viewModel.addFavouriteCharacter(widget.favouriteCharacterModel.character);
      widget.favouriteCharacterModel.isFavourite = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FavouritesViewModel>();
    Character favCharacter = widget.favouriteCharacterModel.character;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(favCharacter.image ?? ''),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildText(
                          context: context,
                          text: favCharacter.name ?? '',
                          fontWeight: FontWeight.w500),
                      infoWidget(
                          context: context,
                          title: 'Köken',
                          val: favCharacter.origin?.name ?? 'aa'),
                      infoWidget(
                          context: context,
                          title: 'Durum',
                          val: favCharacter.status ?? ''),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () => toggleFavourite(),
              icon: Icon(
                widget.favouriteCharacterModel.isFavourite
                    ? Icons.bookmark
                    : Icons.bookmark_border,
                size: 34,
              )),
        ],
      ),
    );
  }

  Column infoWidget(
      {required BuildContext context,
      required String title,
      required String val}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildText(context: context, text: title, fontWeight: FontWeight.w300),
        _buildText(context: context, text: val, fontWeight: FontWeight.w500),
      ],
    );
  }

  Widget _buildText(
      {required BuildContext context,
      required String text,
      double? fontSize,
      required FontWeight fontWeight}) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: Theme.of(context).colorScheme.onSurface),
    );
  }
}
