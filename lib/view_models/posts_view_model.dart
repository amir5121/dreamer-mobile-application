import 'package:dreamer/common/request_notifier.dart';
import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/models/post/post_response.dart';

class PostViewModel extends RequestNotifier {
  PostResponse _posts;

  Future<PostResponse> loadDeeperPosts() async {
    return _posts = await makeRequest(
      () => Singleton().client.getTimeline(showMulti: true),
    );
  }

  Future<PostResponse> loadTimelinePosts(page) async {
    return await makeRequest(
      () => Singleton().client.getTimeline(showMulti: false, page: page),
      notify: false,
    );
  }

  Future<PostResponse> loadMyJournal(page) async {
    return await makeRequest(
      () => Singleton().client.getPosts(page: page),
      notify: false,
    );
  }

  PostResponse get posts {
    return _posts;
  }
}
