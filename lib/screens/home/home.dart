import 'package:dreamer/common/constants.dart';
import 'package:dreamer/models/post/post.dart';
import 'package:dreamer/screens/home/home_heading.dart';
import 'package:dreamer/view_models/posts_view_model.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PagingController<int, Post> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    PostViewModel timelineViewModel = PostViewModel();
    _pagingController.addPageRequestListener((pageKey) {
      timelineViewModel.loadTimelinePosts(pageKey).then(
        (PostViewModel postsResults) {
          if (postsResults.hasError == true) {
            if (timelineViewModel.errorStatus == 404) {
              _pagingController.appendLastPage([]);
            } else {
              _pagingController.error = postsResults.errorMessage;
            }
          } else {
            if (pageKey == 1) {
              // this is for heading
              _pagingController.appendPage([Post.empty()], pageKey + 1);
            }
            if (postsResults.posts?.data.next == null) {
              _pagingController
                  .appendLastPage(postsResults.posts!.data.results);
            } else {
              _pagingController.appendPage(
                  postsResults.posts!.data.results, pageKey + 1);
            }
          }
        },
      );
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
        item.text?[0] ?? "N?A",
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Post>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Post>(
        noItemsFoundIndicatorBuilder: (_) => Center(
          child: Text(
            "Journal is empty!",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        itemBuilder: (context, item, index) {
          if (index == 0) {
            return HomeHeading();
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
