import 'package:dreamer/models/dream/dream.dart';
import 'package:dreamer/screens/journal/journal_post_item.dart';
import 'package:dreamer/screens/journal/profile_header.dart';
import 'package:dreamer/view_models/dreams_view_model.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class Journal extends StatefulWidget {
  @override
  _JournalState createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  @override
  void initState() {
    var dreamViewModel = Provider.of<DreamViewModel>(context, listen: false);
    _pagingController.addPageRequestListener((pageKey) {
      dreamViewModel.loadMyJournal(pageKey).then(
        (DreamViewModel dreams) {
          if (dreams.hasError == true) {
            if (dreamViewModel.errorStatus == 404) {
              _pagingController.appendLastPage([]);
            } else {
              _pagingController.error = dreams.errorMessage;
            }
          } else {
            if (dreams.dreams.data.next == null) {
              _pagingController.appendLastPage(dreams.dreams.data.results);
            } else {
              _pagingController.appendPage(dreams.dreams.data.results, pageKey + 1);
            }
          }
        },
      );
    });

    super.initState();
  }

  final PagingController<int, Dream> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  Widget build(BuildContext context) {
    _pagingController.refresh();
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              // floating: true,
              // pinned: true,
              delegate: ProfileHeader(),
            ),
            PagedSliverList<int, Dream>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Dream>(
                itemBuilder: (context, item, index) => dreamItem(
                  item,
                  context,
                  () => _pagingController.refresh(),
                ),
                noItemsFoundIndicatorBuilder: (_) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Journal is empty!",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "zzz time?",
                    ),
                      ],
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
