import 'package:dreamer/common/request_notifier.dart';
import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/models/dream/dream.dart';
import 'package:dreamer/models/dream/dream_response.dart';

class JournalViewModel extends RequestNotifier {
  DreamResponse _dreams;

  Future<JournalViewModel> loadMyJournal(page) async {
    _dreams = await makeRequest(
      () => Singleton().client.getDreams(page: page),
      notify: false,
    );
    return this;
  }

  Future<JournalViewModel> submitDream(Dream dream) async {
    await makeRequest(
      () => Singleton().client.submitDream(dream: dream),
    );
    return this;
  }

  DreamResponse get dreams {
    return _dreams;
  }
}
