import 'package:dreamer/models/post/post.dart';
import 'package:dreamer/screens/journal/journal_post_item.dart';
import 'package:dreamer/screens/journal/profile_header.dart';
import 'package:dreamer/view_models/posts_view_model.dart';
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
    var postViewModel = Provider.of<PostViewModel>(context, listen: false);
    _pagingController.addPageRequestListener((pageKey) {
      postViewModel.loadMyJournal(pageKey + 1).then(
        (PostViewModel postsResults) {
          if (postsResults.hasError == true) {
            if (postViewModel.errorStatus == 404) {
              _pagingController.appendLastPage([]);
            } else {
              _pagingController.error = postsResults.errorMessage;
            }
          } else {
            if (postsResults.posts.data.next == null) {
              _pagingController.appendLastPage(postsResults.posts.data.results);
            } else {
              _pagingController.appendPage(postsResults.posts.data.results, pageKey + 1);
            }
          }
        },
      );
    });

    super.initState();
  }

  final PagingController<int, Post> _pagingController = PagingController(firstPageKey: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              // floating: true,
              // pinned: true,
              delegate: ProfileHeader(),
            ),
            PagedSliverList<int, Post>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Post>(
                itemBuilder: (context, item, index) => journalPostItem(item, context),
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
