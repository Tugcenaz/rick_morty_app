import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/app/models/character_model.dart';
import 'package:rick_morty_app/app/router.dart';

import '../viewmodel/favourites_viewmodel.dart';

class CharacterCardWidget extends StatefulWidget {
  Character character;
  bool isFavourite;

  CharacterCardWidget({
    super.key,
    required this.character,
    required this.isFavourite,
  });

  @override
  State<CharacterCardWidget> createState() => _CharacterCardWidgetState();
}

class _CharacterCardWidgetState extends State<CharacterCardWidget> {
  void favouriteCharacter() {
    if (widget.isFavourite) {
      //locator.get<PreferencesService>().removeCharacter(widget.character.id!);
      Provider.of<FavouritesViewModel>(context, listen: false)
          .removeCharacter(widget.character.id!);
      widget.isFavourite = false;
      print("if");
    } else {
      // locator.get<PreferencesService>().saveCharacter(widget.character.id!);
      print("else");
      Provider.of<FavouritesViewModel>(context, listen: false)
          .saveCharacter(widget.character.id!);
      widget.isFavourite = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Character character = widget.character;
    return Bounceable(
      onTap: () {
        //tıklama anında buradaki characteri başka sayfaya aktarıcaz
        context.push(AppRoutes.characterProfile,extra: character);
        print("tapped");
      },
      child: Padding(
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
                  Hero(tag: character.image!,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(character.image ?? ''),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildText(
                            context: context,
                            text: character.name ?? '',
                            fontWeight: FontWeight.w500),
                        infoWidget(
                            context: context,
                            title: 'Köken',
                            val: character.origin?.name ?? 'aa'),
                        infoWidget(
                            context: context,
                            title: 'Durum',
                            val: character.status ?? ''),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () => favouriteCharacter(),
                icon: Icon(
                  widget.isFavourite ? Icons.bookmark : Icons.bookmark_border,
                  size: 34,
                )),
          ],
        ),
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
