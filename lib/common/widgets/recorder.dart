import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants.dart';

class Recorder extends StatefulWidget {
  @override
  _RecorderState createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  bool _hasRecorded = false;
  bool _isRecording = false;
  Duration _recordingDuration;
  final FlutterSoundRecorder _soundRecorder = new FlutterSoundRecorder();
  final FlutterSoundPlayer _soundPlayer = new FlutterSoundPlayer();

  String tempPath;

  @override
  void dispose() {
    // Be careful : you must `close` the audio session when you have finished with it.
    _soundRecorder.closeAudioSession();
    _soundPlayer.closeAudioSession();
    // _mPlayerIsInitiated = false;
    super.dispose();
  }

  void asyncSetUp() async {
    Directory tempDir = await getTemporaryDirectory();
    tempPath = "${tempDir.path}/dreamer.acc";
  }

  @override
  void initState() {
    asyncSetUp();
    _soundRecorder.openAudioSession().then((value) {
      // setState(() {
      //   _mPlayerIsInitiated = true;
      // });
    });
    _soundRecorder.onProgress.listen((RecordingDisposition e) {
      Duration maxDuration = e.duration;
      // double decibels = e.decibels;
      print("bbbbbbbbbbbb ${e.decibels} ${e.duration}");

      if (maxDuration.inMilliseconds % 10 == 0) {
        setState(() {
          _recordingDuration = maxDuration;
        });
      }
    });
    _soundPlayer
        .openAudioSession()
        .then((value) => _soundPlayer.onProgress.listen((PlaybackDisposition e) {
              print("AAAAAAAAAAAAAAAA ${e.position} ${e.duration}");
            }));

    super.initState();
  }

  Future<Null> _recordAudio() async {
    if (await Permission.microphone.request().isGranted) {
      if (_soundRecorder.isStopped) {
        _soundRecorder.startRecorder(
          toFile: tempPath,
          codec: Codec.aacMP4,
        );

        setState(() {
          _isRecording = true;
          _hasRecorded = false;
        });
      } else {
        setState(() {
          _isRecording = false;
          _hasRecorded = true;
        });
        _soundRecorder.stopRecorder();
      }
    } else if (await Permission.microphone.isPermanentlyDenied) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 6),
          action: SnackBarAction(
            label: 'Open settings',
            onPressed: () {
              openAppSettings();
            },
          ),
          content: Text(
            "Permission has been permanently denied. Grant permission from settings",
          ),
        ),
      );
    } else {
      // await Permission.microphone.request().then((value) => _recordAudio());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_hasRecorded) ...[
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    border: Border.all(width: 1, color: Constants.accentColor),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.play_arrow),
                        onPressed: () {
                          _soundPlayer.startPlayer(
                            fromURI: tempPath,
                            codec: Codec.aacMP4,
                            whenFinished: () {
                              print('I hope you enjoyed listening to this song');
                            },
                          );
                        },
                      ),
                      Text("..."),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _hasRecorded = false;
                  });
                },
              ),
            ],
          )
        ],
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment:
              _isRecording ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
          children: [
            if (_isRecording)
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(_recordingDuration.toString()),
                ],
              ),
            if (_isRecording) Text("Select to cancel $_isRecording"),
            if (!_hasRecorded)
              Container(
                decoration: BoxDecoration(
                  color: Constants.deepPurple[500],
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () {
                    _recordAudio();
                  },
                ),
              ),
          ],
        ),
      ],
    );
  }
}
