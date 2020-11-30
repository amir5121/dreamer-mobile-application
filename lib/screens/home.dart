import 'package:dreamer/view_models/posts_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PostViewModel>(
      builder: (context, timeline, child) {
        if (!timeline.isLoading && !timeline.hasError) {
          return Container(
            child: Text(timeline.posts?.data?.results[0]?.text[0]),
          );
        }
        return Text("Loading");
      },
    );
  }
}
