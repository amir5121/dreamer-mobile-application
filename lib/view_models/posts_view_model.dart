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

  Future<PostViewModel> loadTimelinePosts(page) async {
    await makeRequest(
      () => Singleton().client.getTimeline(showMulti: false, page: page),
      notify: false,
    );
    return this;
  }

  Future<PostViewModel> loadMyJournal(page) async {
    await makeRequest(
      () => Singleton().client.getPosts(page: page),
      notify: false,
    );
    return this;
  }

  PostResponse get posts {
    return _posts;
  }
}
