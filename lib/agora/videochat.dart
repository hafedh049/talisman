import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:flutter/material.dart';
import 'package:tesla/periodictable/cte.dart';

class VideoChat extends StatefulWidget {
  const VideoChat(
      {Key? key,
      required this.token,
      required this.role,
      required this.channelName})
      : super(key: key);
  final ClientRole role;
  final String channelName;
  final String token;
  @override
  State<VideoChat> createState() => _VideoChatState();
}

class _VideoChatState extends State<VideoChat> {
  final String appId = "00b4ed75158748a8bb16b9ca5ee6d25f";

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    super.dispose();
    users.clear();
    engine.leaveChannel();
    engine.destroy();
  }

  Future<void> initialize() async {
    if (appId.isEmpty) {
      setState(() {
        infoStrings.add(
            "APP_ID is missing, please provide your APP_ID in settings.dart");
        infoStrings.add("Agora Engine is not starting");
      });
      return;
    }
    engine = await RtcEngine.create(appId);
    await engine.enableVideo();
    await engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await engine.setClientRole(widget.role);
    addAgoraEventHandlers();
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = const VideoDimensions(width: 1920, height: 1080);
    await engine.setVideoEncoderConfiguration(configuration);
    await engine.joinChannel(widget.token, widget.channelName, null, 0);
  }

  Widget viewRows() {
    final List<StatefulWidget> list = [];
    if (widget.role == ClientRole.Broadcaster) {
      list.add(const rtc_local_view.SurfaceView());
    }
    for (int uid in users) {
      list.add(rtc_remote_view.SurfaceView(
        channelId: widget.channelName,
        uid: uid,
      ));
    }
    return Column(
      children: List.generate(
        list.length,
        (index) => Expanded(
          child: list[index],
        ),
      ),
    );
  }

  Widget toolbar() {
    if (widget.role == ClientRole.Audience) {
      return const SizedBox();
    }
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            padding: const EdgeInsets.all(12.0),
            color: Colors.white,
            onPressed: () {
              setState(() {
                muted = !muted;
                engine.muteLocalAudioStream(muted);
              });
            },
            icon: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.green : Colors.blue,
              size: 20,
            ),
          ),
          IconButton(
            padding: const EdgeInsets.all(15.0),
            color: Colors.red,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 20,
            ),
          ),
          IconButton(
            padding: const EdgeInsets.all(12.0),
            color: Colors.white,
            onPressed: () {
              engine.switchCamera();
            },
            icon: const Icon(
              Icons.switch_camera,
              color: Colors.blue,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget panel() {
    return Visibility(
      visible: viewPanel,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 48),
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          heightFactor: .5,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 48,
            ),
            child: ListView.builder(
              reverse: true,
              itemCount: infoStrings.length,
              itemBuilder: (context, index) {
                if (infoStrings.isEmpty) {
                  return const Text(
                    "No Info At The Moment",
                    style: TextStyle(fontSize: 10),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: .3,
                    horizontal: 10,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 5,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            infoStrings[index],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 10),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void addAgoraEventHandlers() {
    engine.setEventHandler(RtcEngineEventHandler(
      error: (err) {
        setState(() {
          final info = "Error : ${err.name}";
          infoStrings.add(info);
        });
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        setState(() {
          final info = "Join Channel : $channel, uid : $uid";
          infoStrings.add(info);
        });
      },
      leaveChannel: (stats) {
        setState(() {
          infoStrings.add("Leave Channel");
          users.clear();
        });
      },
      userJoined: (uid, elapsed) {
        setState(() {
          final info = "User Joined : $uid";
          infoStrings.add(info);
          users.add(uid);
        });
      },
      userOffline: (uid, elapsed) {
        setState(() {
          final info = "User Offline : $uid";
          infoStrings.add(info);
          users.remove(uid);
        });
      },
      firstRemoteVideoFrame: (uid, width, height, elapsed) {
        setState(() {
          final info = "First Remote Video :  $uid = ($width x $height)";
          infoStrings.add(info);
        });
      },
    ));
  }

  final List<int> users = <int>[];
  final infoStrings = <String>[];
  bool muted = false;
  bool viewPanel = false;
  late RtcEngine engine;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  viewPanel = !viewPanel;
                });
              },
              icon: const Icon(Icons.info_outline))
        ],
        title: const Text(
          "Video Call",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      backgroundColor: primaryColor,
      body: Center(
        child: Stack(
          children: [
            viewRows(),
            panel(),
            toolbar(),
          ],
        ),
      ),
    );
  }
}
