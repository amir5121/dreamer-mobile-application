import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dreamer/common/dream_consumer.dart';
import 'package:dreamer/common/widgets/dots.dart';
import 'package:dreamer/models/post/post.dart';
import 'package:dreamer/view_models/configurations_view_model.dart';
import 'package:dreamer/view_models/posts_view_model.dart';
import 'package:flutter/material.dart';

class HomeHeading extends StatefulWidget {
  @override
  _HomeHeadingState createState() => _HomeHeadingState();
}

class _HomeHeadingState extends State<HomeHeading> {
  int _current = 0;
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
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
              child: Dots(
                count: timeline.posts.data.results.length,
                selected: _current,
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
}
