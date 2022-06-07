import 'dart:io';

import 'package:dreamer/common/constants.dart';
import 'package:dreamer/common/widgets/svg_icon.dart';
import 'package:dreamer/common/widgets/waveform_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Recorder extends StatefulWidget {
  final Function setRecordingDirectory;
  final String? previousRecording;
  final double? recordingLengthInMilliSeconds;
  final List<double>? recordingWave;

  const Recorder(
      {required this.setRecordingDirectory,
      this.previousRecording,
      this.recordingLengthInMilliSeconds,
      this.recordingWave})
      : super();

  @override
  _RecorderState createState() => _RecorderState();
}

enum SoundStatus {
  none,
  working,
  done,
  loading,
  paused,
}

class _RecorderState extends State<Recorder> {
  SoundStatus _recordingStatus = SoundStatus.none;
  SoundStatus _playbackStatus = SoundStatus.none;
  Duration _workDuration = Duration();
  Duration _recordingLength = Duration();
  List<double>? _wave = [];

  final FlutterSoundPlayer _soundPlayer = FlutterSoundPlayer();
  final FlutterSoundRecorder _soundRecorder = FlutterSoundRecorder();

  String tempPath = "";

  @override
  void dispose() {
    _soundRecorder.closeAudioSession();
    _soundPlayer.closeAudioSession();
    super.dispose();
  }

  void asyncSetUp() async {
    Directory tempDir = await getTemporaryDirectory();
    tempPath = "${tempDir.path}/dreamer.aac";
  }

  @override
  void initState() {
    asyncSetUp();
    if (widget.previousRecording != null) {
      _recordingStatus = SoundStatus.done;
      _recordingLength = widget.recordingLengthInMilliSeconds != null
          ? Duration(
              milliseconds: widget.recordingLengthInMilliSeconds!.toInt())
          : Duration();
      _wave = widget.recordingWave;
    }
    super.initState();
  }

  Future<Null> _recordAudio() async {
    if (await Permission.microphone.request().isGranted) {
      if (_soundRecorder.isStopped) {
        setState(() {
          _recordingStatus = SoundStatus.loading;
        });
        _soundRecorder
            .openAudioSession()
            .then((FlutterSoundRecorder? soundRecorder) {
          setState(() {
            _workDuration = Duration();
          });
          soundRecorder?.setSubscriptionDuration(Duration(milliseconds: 100));
          soundRecorder
              ?.startRecorder(
            toFile: tempPath,
            codec: Codec.aacMP4,
          )
              .then((_) {
            setState(() {
              _recordingStatus = SoundStatus.working;
            });
            _wave = [];
          });

          soundRecorder?.onProgress?.listen((RecordingDisposition e) {
            Duration maxDuration = e.duration;
            if (_wave != null && e.decibels != null) _wave!.add(e.decibels!);
            _recordingLength = maxDuration;

            setState(() {
              _workDuration = maxDuration;
            });
          });
        });
      } else {
        setState(() {
          _recordingStatus = SoundStatus.loading;
          _workDuration = Duration();
        });
        _soundRecorder.stopRecorder().then(
              (_) => _soundRecorder.closeAudioSession().then(
                (_) {
                  widget.setRecordingDirectory(tempPath, _wave,
                      _recordingLength.inMilliseconds.toDouble());
                  setState(() {
                    _recordingStatus = SoundStatus.done;
                  });
                },
              ),
            );
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
    final bool _isRecording = _recordingStatus == SoundStatus.working;
    return Column(
      children: [
        if (_recordingStatus == SoundStatus.done) ...[
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
                        icon: Icon(
                          _playbackStatus == SoundStatus.working
                              ? Icons.pause
                              : Icons.play_arrow,
                        ),
                        onPressed: () {
                          _playbackAudio();
                        },
                      ),
                      Expanded(
                        child: WaveformSlider(
                          wave: _wave,
                          progress: _workDuration.inMilliseconds /
                              _recordingLength.inMilliseconds,
                          tapCallback: (double seekProgress) =>
                              _soundPlayer.seekToPlayer(
                            Duration(
                              milliseconds: (_recordingLength.inMilliseconds *
                                      seekProgress)
                                  .toInt(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8)
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  if (_playbackStatus == SoundStatus.working) {
                    setState(() {
                      _playbackStatus = SoundStatus.loading;
                    });
                    _soundPlayer.stopPlayer().then((_) => setState(() {
                          _playbackStatus = SoundStatus.none;
                        }));
                  } else {
                    setState(() {
                      _recordingStatus = SoundStatus.none;
                    });
                  }
                },
              ),
            ],
          )
        ],
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: _isRecording
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.end,
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
                  Text(_workDuration.toString()),
                ],
              ),
            if (_isRecording) Text("Select to cancel $_isRecording"),
            if (_recordingStatus == SoundStatus.none ||
                _recordingStatus == SoundStatus.working)
              Container(
                decoration: BoxDecoration(
                  color: Constants.deepPurple[500],
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: SVGIcon(
                    color: Constants.tertiaryColor,
                    assetAddress: 'assets/images/mic.svg',
                    size: 28,
                  ),
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

  void _playbackAudio() {
    if (_playbackStatus == SoundStatus.none ||
        _playbackStatus == SoundStatus.done) {
      setState(() {
        _playbackStatus = SoundStatus.loading;
      });
      _soundPlayer.openAudioSession().then((FlutterSoundPlayer? soundPlayer) {
        setState(() {
          _workDuration = Duration();
        });
        soundPlayer?.setSubscriptionDuration(Duration(milliseconds: 100));
        soundPlayer?.onProgress?.listen((PlaybackDisposition e) {
          Duration maxDuration = e.position;
          // double decibels = e.decibels;
          // print("bbbbbbbbbbbb ${e.decibels} ${e.duration}");
          setState(() {
            _workDuration = maxDuration;
          });
          // print("AAAAAAAAAAAAAAAA ${e.position} ${e.duration}");
        });
        soundPlayer
            ?.startPlayer(
              fromURI: tempPath,
              codec: Codec.aacMP4,
              whenFinished: () {
                setState(() {
                  _playbackStatus = SoundStatus.loading;
                });
                _soundPlayer.closeAudioSession().then((_) => setState(() {
                      _playbackStatus = SoundStatus.done;
                      _workDuration = Duration();
                    }));
              },
            )
            .then((_) => setState(() {
                  _playbackStatus = SoundStatus.working;
                }));
      });
    } else if (_playbackStatus == SoundStatus.working) {
      setState(() {
        _playbackStatus = SoundStatus.loading;
      });
      _soundPlayer.pausePlayer().then((_) => setState(() {
            _playbackStatus = SoundStatus.paused;
          }));
    } else if (_playbackStatus == SoundStatus.paused) {
      setState(() {
        _playbackStatus = SoundStatus.loading;
      });
      _soundPlayer.resumePlayer().then((_) => setState(() {
            _playbackStatus = SoundStatus.working;
          }));
    }
  }
}
