import 'package:carousel_slider/carousel_slider.dart';
import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/dream_consumer.dart';
import 'package:dreamer/models/post/post.dart';
import 'package:dreamer/models/post/post_response.dart';
import 'package:dreamer/view_models/configurations_view_model.dart';
import 'package:dreamer/view_models/posts_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _current = 0;
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

  Widget _homeHeading() {
    CarouselController buttonCarouselController = CarouselController();

    return DreamConsumer<PostViewModel>(
      loadingBuilder: (context, timeline, child) {
        return Text("Loading");
      },
      errorBuilder: (context, timeline, child) {
        return Text(timeline.errorMessage);
      },
      builder: (context, timeline, child) {
        return Column(
          children: [
            Card(
              margin: EdgeInsets.only(left: 16, right: 16),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: DreamConsumer<ConfigurationsViewModel>(
                loadingBuilder: (context, configurations, child) {
                  return Text("I should have had the configurations by now. loading...");
                },
                builder: (context, configurations, child) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          configurations.configurations.data.mainBackground,
                        ),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    child: CarouselSlider(
                      carouselController: buttonCarouselController,
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                      items: timeline.posts.data.results.map<Widget>((Post post) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    post.text[0],
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                OutlineButton(
                                  onPressed: () {},
                                  child: Text("Go deeper"),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: timeline.posts.data.results.map<Widget>(
                  (post) {
                    int index = timeline.posts.data.results.indexOf(post);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? Constants.tertiaryColor
                            : Constants.accentColor,
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            // Container(
            //   child: Text(timeline.posts?.data?.results[0]?.text[0]),
            // )
          ],
        );
      },
    );
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
            return _homeHeading();
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
