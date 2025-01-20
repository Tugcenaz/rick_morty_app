import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/app/components/appbar_widget.dart';
import 'package:rick_morty_app/app/viewmodel/character_profile_viewmodel.dart';
import '../../components/decorated_container.dart';
import '../../models/character_model.dart';

class CharacterProfileView extends StatefulWidget {
  Character character;

  CharacterProfileView({super.key, required this.character});

  @override
  State<CharacterProfileView> createState() => _CharacterProfileViewState();
}

class _CharacterProfileViewState extends State<CharacterProfileView> {
  @override
  void initState() {
    super.initState();
    context
        .read<CharacterProfileViewmodel>()
        .getEpisodes(widget.character.episode ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const AppbarWidget(
          isTransparentBackground: true,
          title: "Karakter",
        ),
        body: DecoratedContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              characterAvatar(context),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(50),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      children: [
                        characterName(),
                        characterDetail(context),
                        episodesTitle(),
                        episodesWidget(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget episodesTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 30),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Bölümler (${widget.character.episode?.length})",
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
    );
  }

  Padding characterDetail(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 14,
        runSpacing: 14,
        children: [
          characterInfo(context, title: widget.character.status ?? ""),
          characterInfo(context, title: widget.character.origin?.name ?? ""),
          characterInfo(context, title: widget.character.gender ?? ""),
          characterInfo(context, title: widget.character.species ?? ""),
        ],
      ),
    );
  }

  Text characterName() {
    return Text(
      widget.character.name ?? "",
      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
    );
  }

  Widget episodesWidget(context) {
    return Consumer<CharacterProfileViewmodel>(
        builder: (context, viewModel, child) {
      return Expanded(
        child: ListView.separated(
          padding: const EdgeInsets.only(top: 12),
          itemCount: viewModel.episodeList!.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(
                Icons.face_retouching_natural,
                size: 45,
              ),
              title: Text(
                viewModel.episodeList?[index].name??'',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(viewModel.episodeList?[index].episode ?? ''),
              trailing: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios)),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Theme.of(context).colorScheme.tertiary,
              indent: 35,
              endIndent: 35,
            );
          },
        ),
      );
    });
  }

  Container characterInfo(BuildContext context, {required String title}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(13)),
      child: Text(title),
    );
  }

  Padding characterAvatar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100, bottom: 70),
      child: CircleAvatar(
        radius: 70,
        backgroundColor: Theme.of(context).primaryColor,
        child: CircleAvatar(
          radius: 68,
          backgroundColor: Theme.of(context).colorScheme.surface,
          child: Hero(
            tag: widget.character.image!,
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.character.image ?? ""),
              radius: 66,
            ),
          ),
        ),
      ),
    );
  }
}
