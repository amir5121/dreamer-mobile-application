import 'package:dreamer/common/request_notifier.dart';
import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/models/post/post_response.dart';
import 'package:dreamer/models/post/post_retrieve.dart';

class PostViewModel extends RequestNotifier {
  PostResponse? _posts;
  PostRetrieve? _lastRetrievedPost;

  void loadDeeperPosts() async {
    _posts = await makeRequest(
      () => Singleton().client.getTimeline(showMulti: true),
    );
  }

  void getPost(int id) async {
    _lastRetrievedPost = await makeRequest(
      () => Singleton().client.getPost(id: id),
    );
  }

  Future<PostViewModel> loadTimelinePosts(page) async {
    _posts = await makeRequest(
      () => Singleton().client.getTimeline(showMulti: false, page: page),
      notify: false,
    );
    return this;
  }

  PostResponse? get posts {
    return _posts;
  }

  PostRetrieve? get lastRetrievedPost {
    return _lastRetrievedPost;
  }
}
