import 'package:carousel_slider/carousel_slider.dart';
import 'package:dreamer/common/dream_consumer.dart';
import 'package:dreamer/common/widgets/dots.dart';
import 'package:dreamer/common/widgets/dreamer_scaffold.dart';
import 'package:dreamer/models/post/post.dart';
import 'package:dreamer/view_models/posts_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostDetail extends StatefulWidget {
  final int postId;

  const PostDetail({Key key, this.postId}) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  CarouselController buttonCarouselController = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostViewModel>(
      create: (context) => PostViewModel()..getPost(widget.postId),
      child: DreamerScaffold(
        body: DreamConsumer<PostViewModel>(
          loadingBuilder: (context, lastRetrievedPost, child) => Text("Loading"),
          builder: (context, retrievedPost, child) {
            Post post = retrievedPost.lastRetrievedPost.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                postTextCarousel(post),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.mood),
                          onPressed: () {},
                        ),
                        Text("123 Likes")
                      ],
                    ),
                    Dots(
                      count: post.text.length,
                      selected: _current,
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  CarouselSlider postTextCarousel(Post post) {
    return CarouselSlider(
      carouselController: buttonCarouselController,
      options: CarouselOptions(
        aspectRatio:
            MediaQuery.of(context).orientation == Orientation.portrait ? 3 / 1 : 9 / 1,
        viewportFraction: 1,
        onPageChanged: (index, reason) {
          setState(
            () {
              _current = index;
            },
          );
        },
      ),
      items: post.text.map<Widget>(
        (String text) {
          return Builder(
            builder: (BuildContext context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
                      child: Text(
                        text,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ).toList(),
    );
  }
}
