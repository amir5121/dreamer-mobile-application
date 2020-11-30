import 'package:dreamer/common/request_notifier.dart';
import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/models/post/post_response.dart';

class PostViewModel extends RequestNotifier {
  PostResponse _posts;

  void loadPosts() async {
    _posts = await makeRequest(
      () => Singleton().client.getPosts('timeline'),
    );
  }

  PostResponse get posts {
    return _posts;
  }
}
