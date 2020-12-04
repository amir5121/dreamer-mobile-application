import 'package:dreamer/common/request_notifier.dart';
import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/models/post/post_response.dart';

class PostViewModel extends RequestNotifier {
  PostResponse _posts;

  Future<PostResponse> loadDeeperPosts() async {
    return _posts = await makeRequest(
      () => Singleton().client.getPosts('timeline', true),
    );
  }

  Future<PostResponse> loadTimelinePosts(page) async {
    return await makeRequest(
      () => Singleton().client.getPosts('timeline', false, page),
      notify: false,
    );
  }

  PostResponse get posts {
    return _posts;
  }
}
