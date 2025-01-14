import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/app/components/character_card_widget.dart';
import 'package:rick_morty_app/app/viewmodel/characters_viewmodel.dart';
import 'package:rick_morty_app/app/viewmodel/favourites_viewmodel.dart';

import '../models/character_model.dart';
import '../models/favourite_character_model.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  final PagingController<int, Character> _pagingController =
      PagingController(firstPageKey: 0);

  //int next = 1;
  List<int> favouritesList = [];

  @override
  void initState() {
    super.initState();
    _getFavourites();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  bool isLoading = true;

  void setLoading(bool value) {
    isLoading = value;
    setState(() {});
  }

  void _getFavourites() async {
    await context.read<FavouritesViewModel>().getFavourites();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      await context.read<CharactersViewModel>().getCharacters();

      final characterModel = context.read<CharactersViewModel>().characterModel;
      if (characterModel == null || characterModel.character == null) {
        return;
      }
      List<Character> characterList = characterModel.character!;

      final bool isLastPage = characterList.length < 20;
      if (isLastPage) {
        _pagingController.appendLastPage(characterList);
      } else {
        final nextPageKey = pageKey + characterList.length;
        _pagingController.appendPage(characterList, nextPageKey);
        //next = int.parse(characterModel.info!.next!.split("=")[1]);
      }
    } catch (e) {
      _pagingController.error = e;
      print("error: ${e}");
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CharactersViewModel>();
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            _searchInputWidget(context, viewModel: viewModel),
            /*    viewModel.characterModel == null
                ? const CircularProgressIndicator.adaptive()
                : CharacterCardListView(
                    characters: viewModel.characterModel!.character!,
                    onLoadMore: () => viewModel.getCharactersMore(),
                    loadMore: viewModel.loadMore,
                  )*/
            Consumer<CharactersViewModel>(
              builder: (context, viewModel, child) {
                return Flexible(
                  child: PagedListView<int, Character>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Character>(
                      newPageProgressIndicatorBuilder: (BuildContext context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      noItemsFoundIndicatorBuilder: (BuildContext context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      itemBuilder: (context, item, index) {
                        FavouriteCharacterModel favChar;
                        final list =
                            context.read<FavouritesViewModel>().favourites;
                        favChar = FavouriteCharacterModel(
                            character: item, isFavourite: false);

                        if (list.contains(favChar)) {
                          favChar = FavouriteCharacterModel(
                              character: item, isFavourite: true);
                          print("true");
                        }
                        print("false");
                        favChar = FavouriteCharacterModel(
                            character: item, isFavourite: false);

                        return CharacterCardWidget(
                          /*  character: item,
                          isFavourite: fav,*/
                          favouriteCharacterModel: favChar,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      )),
    );
  }

  Widget _searchInputWidget(BuildContext context,
      {required CharactersViewModel viewModel}) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 16.0),
      child: TextFormField(
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (String value) async {
          if (value.isNotEmpty) {
            _pagingController.itemList?.clear();
            await viewModel.getSearchCharacters(name: value);
            final characterList = viewModel.characterModel?.character;

            _pagingController.appendLastPage(characterList!);
          } else {
            _pagingController.itemList?.clear(); // Mevcut listeyi temizle
            viewModel.clearCharacter(); // Sayfayı sıfırla
            _fetchPage(0); // İlk sayfayı yükle
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.primary,
            size: 26,
          ),
          suffixIcon:
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w400),
          labelText: 'Karakterlerde Ara',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
