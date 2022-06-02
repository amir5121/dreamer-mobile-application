import 'dart:io';

import 'package:dreamer/common/request_notifier.dart';
import 'package:dreamer/common/singleton.dart';
import 'package:dreamer/models/dream/dream.dart';
import 'package:dreamer/models/dream/dream_response.dart';
import 'package:dreamer/models/dream/dream_retrieve.dart';
import 'package:dreamer/models/dream/feeling.dart';
import 'package:dreamer/models/utils/upload_response.dart';

class DreamViewModel extends RequestNotifier {
  DreamResponse? _dreams;
  DreamRetrieve? _dream;

  Future<DreamViewModel> loadMyJournal(page) async {
    _dreams = await makeRequest(
      () => Singleton().client.getDreams(page: page),
      notify: false,
    );
    return this;
  }

  Future<DreamViewModel> loadDream(String identifier) async {
    _dream = await makeRequest(
      () => Singleton().client.getDream(identifier: identifier),
    );
    return this;
  }

  Future<DreamViewModel> deleteDream(String identifier) async {
    await makeRequest(
      () => Singleton().client.deleteDream(identifier: identifier),
    );
    return this;
  }

  Future<DreamViewModel> submitDream(Dream dream) async {
    if (dream.voice != null && dream.voice!.contains('http')) {
      await makeRequest<UploadResponse>(
        () async => {
          if (dream.voice != null)
            await Singleton().client.uploadFile(
                  File(dream.voice!),
                )
        },
      ).then((UploadResponse? value) {
        if (!this.hasError) {
          dream.voice = value?.data.filePath;
        }
      });
    }
    if (!this.hasError) {
      await makeRequest(
        () {
          dream.feelings?.removeWhere((Feeling feeling) => feeling.rate == 0);
          if (dream.identifier != null) {
            Singleton()
                .client
                .updateDream(identifier: dream.identifier!, dream: dream);
          } else {
            Singleton().client.submitDream(dream: dream);
          }
        },
      );
    }
    return this;
  }

  DreamResponse? get dreams {
    return _dreams;
  }

  DreamRetrieve? get dream {
    return _dream;
  }
}
