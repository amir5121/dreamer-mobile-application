import 'package:carousel_slider/carousel_slider.dart';
import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/dream_consumer.dart';
import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/models/post/post.dart';
import 'package:dreamer/models/post/post_response.dart';
import 'package:dreamer/view_models/posts_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _current = 0;
  final PagingController<int, Post> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) async {
      PostResponse posts =
          await Singleton().client.getPosts('timeline', false, pageKey + 1);
      print("Adding postFrame callBack $posts");
      if (posts.data.next == null) {
        _pagingController.appendLastPage(posts.data.results);
      } else {
        _pagingController.appendPage(posts.data.results, pageKey + 1);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CarouselController buttonCarouselController = CarouselController();

    return Column(
      children: [
        DreamConsumer<PostViewModel>(
          loadingBuilder: (context, timeline, child) {
            return Text("Loading");
          },
          errorBuilder: (context, timeline, child) {
            return Text(timeline.errorMessage);
          },
          builder: (context, timeline, child) {
            // _pagingController.appendPage(
            //   Provider.of<PostViewModel>(context).posts.data.results,
            //   0,
            // );
            return Column(
              children: [
                Card(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/background.webp"),
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
                      items:
                          timeline.posts.data.results.map<Widget>((Post post) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  post.text[0],
                                  style: Theme.of(context).textTheme.bodyText1,
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
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
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
        ),
        Expanded(
          child: PagedListView<int, Post>(
            // shrinkWrap: true,
            // scrollDirection: Axis.vertical,
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Post>(
              itemBuilder: (context, item, index) => Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Constants.accentColor),
                ),
                child: Text(
                  item.text[0],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
