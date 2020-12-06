import 'package:dreamer/common/request_notifier.dart';
import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/models/dream/dream_response.dart';

class DreamViewModel extends RequestNotifier {
  DreamResponse _dreams;

  Future<DreamViewModel> loadMyJournal(page) async {
    _dreams = await makeRequest(
      () => Singleton().client.getDreams(page: page),
      notify: false,
    );
    return this;
  }

  DreamResponse get dreams {
    return _dreams;
  }
}
