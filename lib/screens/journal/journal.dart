import 'package:dreamer/models/post/post.dart';
import 'package:dreamer/models/post/post_response.dart';
import 'package:dreamer/view_models/posts_view_model.dart';
import 'package:dreamer/screens/journal/journal_post_item.dart';
import 'package:dreamer/screens/journal/profile_header.dart';
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
    _pagingController.addPageRequestListener((pageKey) async {
      PostResponse posts =
          await Provider.of<PostViewModel>(context).loadMyJournal(pageKey + 1);

      if (posts.data.next == null) {
        _pagingController.appendLastPage(posts.data.results);
      } else {
        _pagingController.appendPage(posts.data.results, pageKey + 1);
      }
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
