import 'package:dreamer/common/constants.dart';
import 'package:dreamer/models/post/post.dart';
import 'package:dreamer/models/post/post_response.dart';
import 'package:dreamer/view_models/posts_view_model.dart';
import 'package:dreamer/screens/home/home_heading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PagingController<int, Post> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) async {
      PostResponse posts =
          await Provider.of<PostViewModel>(context).loadTimelinePosts(pageKey + 1);

      if (posts.data.next == null) {
        _pagingController.appendLastPage(posts.data.results);
      } else {
        if (pageKey == 1) {
          // this is for heading
          _pagingController
              .appendPage([Post(null, null, null, null, null, null)], pageKey + 1);
        }
        _pagingController.appendPage(posts.data.results, pageKey + 1);
      }
    });

    super.initState();
  }

  Widget _homeTimelineItem(Post item) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(top: 8, right: 8, left: 8),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Constants.accentColor,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Text(
        item.text[0],
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Post>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Post>(
        itemBuilder: (context, item, index) {
          if (index == 0) {
            return homeHeading(setState);
          }
          return _homeTimelineItem(item);
        },
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
