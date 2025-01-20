import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/app/components/appbar_widget.dart';
import 'package:rick_morty_app/app/components/character_card_widget.dart';
import 'package:rick_morty_app/app/components/decorated_container.dart';
import 'package:rick_morty_app/app/viewmodel/episode_viewmodel.dart';

import '../models/episode_model.dart';
import '../router.dart';

class EpisodesView extends StatefulWidget {
  const EpisodesView({super.key});

  @override
  State<EpisodesView> createState() => _EpisodesViewState();
}

class _EpisodesViewState extends State<EpisodesView> {
  final PagingController<int, Episode> _pagingController =
      PagingController(firstPageKey: 0);

  Future<void> _fetchPage(int pageKey) async {
    try {
      await context.read<EpisodeViewModel>().getAllEpisodes();

      final episodeModel = context.read<EpisodeViewModel>().episodeModel;
      if (episodeModel == null || episodeModel.episode == null) {
        return;
      }
      List<Episode> episodeList = episodeModel.episode!;

      final bool isLastPage = episodeList.length < 20;
      if (isLastPage) {
        _pagingController.appendLastPage(episodeList);
      } else {
        final nextPageKey = pageKey + episodeList.length;
        _pagingController.appendPage(episodeList, nextPageKey);
      }
    } catch (e) {
      _pagingController.error = e;
      print("error: ${e}");
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(
        title: "Bölümler",
        isTransparentBackground: true,
      ),
      body: DecoratedContainer(
        child: Padding(
          padding: const EdgeInsets.only(top: 94),
          child: DecoratedListContainer(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 6),
              child: PagedListView<int, Episode>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Episode>(
                  itemBuilder: (context, item, index) {
                    return episodeListTile(item, context);
                  },
                  newPageProgressIndicatorBuilder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget episodeListTile(Episode episode, BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(
            Icons.face_retouching_natural,
            size: 45,
          ),
          title: Text(
            episode.name ?? '',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            episode.episode ?? '',
          ),
          trailing: IconButton(
              onPressed: () {
                context.push(AppRoutes.episodeCharacters,extra: episode);
              },
              icon: const Icon(Icons.arrow_forward_ios)),
        ),
        Divider(
          color: Theme.of(context).colorScheme.tertiary,
          indent: 35,
          endIndent: 35,
        )
      ],
    );
  }
}
