import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/dream_consumer.dart';
import 'package:dreamer/models/post/post.dart';
import 'package:dreamer/view_models/configurations_view_model.dart';
import 'package:dreamer/view_models/posts_view_model.dart';
import 'package:flutter/material.dart';

Widget homeHeading(Function setState) {
  int _current = 0;
  CarouselController buttonCarouselController = CarouselController();

  return DreamConsumer2<PostViewModel, ConfigurationsViewModel>(
    loadingBuilder: (context, timeline, configurations, child) {
      return Text("Loading");
    },
    errorBuilder: (context, timeline, configurations, child) {
      return Text(timeline.errorMessage);
    },
    builder: (context, timeline, configurations, child) {
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
                  return Builder(builder: (BuildContext context) {
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
                  });
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
