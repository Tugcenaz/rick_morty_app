import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_app/app/components/appbar_widget.dart';
import 'package:rick_morty_app/app/components/decorated_container.dart';
import 'package:rick_morty_app/app/router.dart';
import 'package:rick_morty_app/app/viewmodel/location_viewmodel.dart';
import '../models/location_model.dart';

class LocationsView extends StatefulWidget {
  const LocationsView({super.key});

  @override
  State<LocationsView> createState() => _LocationsViewState();
}

class _LocationsViewState extends State<LocationsView> {
  final PagingController<int, Locations> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      await context.read<LocationViewModel>().getLocations();

      final locationModel = context.read<LocationViewModel>().locationModel;
      if (locationModel == null || locationModel.location == null) {
        return;
      }
      List<Locations> locationList = locationModel.location!;

      final bool isLastPage = locationList.length < 20;
      if (isLastPage) {
        _pagingController.appendLastPage(locationList);
      } else {
        final nextPageKey = pageKey + locationList.length;
        _pagingController.appendPage(locationList, nextPageKey);
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
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const AppbarWidget(
            title: "Konumlar", isTransparentBackground: true),
        body: DecoratedContainer(
          child: Padding(
            padding: const EdgeInsets.only(top: 94),
            child: DecoratedListContainer(child: locationListView(context)),
          ),
        ),
      ),
    );
  }

  Widget locationListView(context) {
    return Consumer<LocationViewModel>(builder: (context, viewModel, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 6),
        child: PagedListView<int, Locations>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Locations>(
            itemBuilder: (context, item, index) {
              return locationCard(item);
            },
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
          ),
        ),
      );
    });
  }

  Widget locationCard(Locations location) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(
            Icons.location_on,
            size: 45,
          ),
          title: Text(
            location?.name ?? '',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Tür: ${location?.type}" ?? ''),
              Text(
                  "Kişi sayısı : ${location?.residents?.length.toString() ?? ''}"),
            ],
          ),
          trailing: IconButton(
              onPressed: () {
                context.push(AppRoutes.residents, extra: location);
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
