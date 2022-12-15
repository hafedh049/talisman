import 'dart:io';
import 'dart:ui';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swipe_to/swipe_to.dart';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:tesla/agora/videochat.dart';
import 'package:tesla/file.dart';
import 'package:tesla/image.dart';
import 'package:tesla/message.dart' as ms;
import 'package:tesla/periodictable/cte.dart';
import 'package:tesla/replymessage.dart';
import 'package:tesla/voicerecord.dart';

class ChatScreen extends StatefulWidget {
  final String senderProfilePicturePath;
  final String currentUserProfilePicturePath;
  final String username;
  final String status;
  final Color color;
  final String currentUserUid;
  final String senderUid;
  const ChatScreen({
    Key? key,
    required this.senderUid,
    required this.currentUserProfilePicturePath,
    required this.username,
    required this.status,
    required this.color,
    required this.senderProfilePicturePath,
    required this.currentUserUid,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final recorder = FlutterSoundRecorder();
  TextEditingController messageController = TextEditingController(text: "");
  bool isMax = true;
  ScrollController scrollController = ScrollController();
  bool showEmoji = false;
  FocusNode messageFocusNode = FocusNode();
  bool willReply = false;
  String replyMessage = "";
  String whoWillReply = "";
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  FirebaseMessaging fcmInstance = FirebaseMessaging.instance;
  String myname = "";
  FilePickerResult? filePickerResult;
  Map<int, double> downloadProgressValue = {};
  TextEditingController channelNameController = TextEditingController(text: "");
  TextEditingController tokenController = TextEditingController(text: "");

  void sendPushNotificationFCM(
      {required String token,
      required String username,
      required String message}) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAS85RqwU:APA91bG5lb1Mg6Fy6KAnmCOXXLJtVVVbqA2GIIaPLuAPicpPHafI3WPD1R_SLslqi-j2fjwICAaK3vz5hFL4GXHpb7wWS2pGm56Z_R2hustCnJu5RiljZzpATj_D3ce8Z_9UcmuNWQmE',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': message,
              'title': username,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': "done",
            },
            'to': token,
          },
        ),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }

  void remove(String id, int index, int length,
      QuerySnapshot<Map<String, dynamic>>? data) async {
    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Material(
              color: Colors.transparent,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () async {
                        if (index == 0) {
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(widget.currentUserUid)
                              .collection("messages")
                              .doc(widget.senderUid)
                              .set({
                            "last_message": length == 1
                                ? ""
                                : data!.docs[index + 1].get("message")
                          });
                        }
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(widget.currentUserUid)
                            .collection("messages")
                            .doc(widget.senderUid)
                            .collection("chats")
                            .doc(id)
                            .delete();
                        if (data!.docs[index].get("type") == "document") {
                          await FirebaseStorage.instance
                              .refFromURL(data.docs[index].get("alphaurl"))
                              .delete()
                              .then((value) => print("deleted"));
                        } else if (data.docs[index].get("type") == "image" ||
                            data.docs[index].get("type") == "audio") {
                          await FirebaseStorage.instance
                              .refFromURL(data.docs[index].get("message"))
                              .delete()
                              .then((value) => print("deleted"));
                        }
                        Fluttertoast.showToast(
                            msg: "Deleted",
                            backgroundColor: Colors.redAccent,
                            textColor: Colors.white);
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.greenAccent,
                        size: 50,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        Clipboard.setData(ClipboardData(
                            text: data!.docs[index].get("message")));
                        Fluttertoast.showToast(
                            msg: "Copied To ClipBoard",
                            backgroundColor: Colors.orange,
                            textColor: Colors.white);
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.copy,
                        color: Colors.greenAccent,
                        size: 50,
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !foundation.kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: 'launch_background',
                importance: Importance.high,
                priority: Priority.high,
                playSound: true,
                enableVibration: false,
              ),
            ),
            payload: "chatscreen");
      }
    });

    /*   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('A new onMessageOpenedApp event was published!');
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            senderUid: widget.senderUid,
            currentUserProfilePicturePath: widget.currentUserProfilePicturePath,
            username: widget.username,
            status: widget.status,
            color: widget.color,
            senderProfilePicturePath: widget.senderProfilePicturePath,
            currentUserUid: widget.currentUserUid,
          ),
        ),
      );
    });*/
  }

  void loadFCM() async {
    if (!foundation.kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.high,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await fcmInstance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    messageController.dispose();
    scrollController.dispose();
    tokenController.dispose();
    channelNameController.dispose();
    super.dispose();
  }

  void initRecorder() async {
    final status = await Permission.microphone.request();
    if (status == PermissionStatus.granted) {
      await recorder.openRecorder();
      recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
    }
  }

  @override
  void initState() {
    /* flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(/*android: AndroidInitializationSettings() */),
      onSelectNotification: (payload) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              senderUid: widget.senderUid,
              currentUserProfilePicturePath:
                  widget.currentUserProfilePicturePath,
              username: widget.username,
              status: widget.status,
              color: widget.color,
              senderProfilePicturePath: widget.senderProfilePicturePath,
              currentUserUid: widget.currentUserUid,
            ),
          ),
        );
      },
    );*/
    initRecorder();
    loadFCM();
    listenFCM();
    getMyName();
    scrollController.addListener(() {
      if (scrollController.offset !=
          scrollController.position.minScrollExtent) {
        isMax = false;
      } else {
        isMax = true;
      }
      setState(() {});
    });
    super.initState();
  }

  void getMyName() async {
    DocumentSnapshot<Map<String, dynamic>> credit = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(widget.currentUserUid)
        .get();
    myname = credit.get("username").toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            FontAwesomeIcons.circleChevronLeft,
            color: Colors.white,
            size: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ClientRole role = ClientRole.Broadcaster;
              bool validateChannelError = false;
              bool validateTokenError = false;
              showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 8,
                        sigmaY: 8,
                      ),
                      child: AlertDialog(
                        backgroundColor: primaryColor,
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                controller: channelNameController,
                                decoration: InputDecoration(
                                    hintText: "Chnannel",
                                    hintStyle:
                                        const TextStyle(color: Colors.white),
                                    errorText: validateChannelError
                                        ? "Channel name is mandatory."
                                        : null),
                              ),
                              TextFormField(
                                style: const TextStyle(color: Colors.white),
                                controller: tokenController,
                                decoration: InputDecoration(
                                    hintText: "Token",
                                    hintStyle:
                                        const TextStyle(color: Colors.white),
                                    errorText: validateTokenError
                                        ? "Token is mandatory."
                                        : null),
                              ),
                              RadioListTile<ClientRole>(
                                title: const Text("Broadcaster",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                value: ClientRole.Broadcaster,
                                groupValue: role,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      role = value!;
                                    },
                                  );
                                },
                              ),
                              RadioListTile<ClientRole>(
                                title: const Text(
                                  "Audience",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                value: ClientRole.Audience,
                                groupValue: role,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      role = value!;
                                    },
                                  );
                                },
                              ),
                              MaterialButton(
                                color: Colors.green,
                                onPressed: () async {
                                  setState(
                                    () {
                                      channelNameController.text
                                              .contains(RegExp(r"^\s*$"))
                                          ? validateChannelError = true
                                          : false;
                                      tokenController.text
                                              .contains(RegExp(r"^\s*$"))
                                          ? validateTokenError = true
                                          : false;
                                    },
                                  );
                                  if (!channelNameController.text
                                          .contains(RegExp(r"^\s*$")) &&
                                      !tokenController.text
                                          .contains(RegExp(r"^\s*$"))) {
                                    await Permission.camera.request();
                                    await Permission.microphone.request();
                                    await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            VideoChat(
                                                channelName:
                                                    channelNameController.text
                                                        .trim(),
                                                role: role,
                                                token: tokenController.text
                                                    .trim()),
                                      ),
                                    );
                                  }
                                },
                                child: const Text(
                                  "Join",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
                },
              );
            },
            icon: const Icon(
              FontAwesomeIcons.video,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: null,
            icon: Icon(
              FontAwesomeIcons.phone,
              color: Colors.white.withOpacity(.5),
              size: 18,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        title: Align(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                        child: Material(
                          color: Colors.transparent,
                          child: InteractiveViewer(
                              child: CachedNetworkImage(
                                  imageUrl: widget.senderProfilePicturePath)),
                        ),
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: widget.color,
                  child: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                        widget.senderProfilePicturePath),
                    radius: 17,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.username.split(" ")[0],
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 5,
                        backgroundColor: widget.color,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      StreamBuilder(
                        builder: (context, snapshot) {
                          return Text(
                            widget.status,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 36, 30, 76),
        surfaceTintColor: Colors.greenAccent,
        shape: const UnderlineInputBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(widget.currentUserUid)
                    .collection("messages")
                    .doc(widget.senderUid)
                    .collection("chats")
                    .orderBy("message_date", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        ListView.builder(
                          reverse: true,
                          //physics: const BouncingScrollPhysics(),
                          controller: scrollController,
                          padding: const EdgeInsets.all(8.0),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            if (snapshot.data!.docs[index]["type"] == "reply") {
                              return snapshot.data!.docs[index]["me"] ==
                                      widget.currentUserUid
                                  ? SwipeTo(
                                      onLeftSwipe: () {
                                        messageFocusNode.requestFocus();
                                        setState(() {
                                          willReply = true;
                                          replyMessage = snapshot
                                              .data!.docs[index]["old_message"];
                                          whoWillReply = myname;
                                        });
                                      },
                                      iconColor: Colors.pinkAccent,
                                      child: GestureDetector(
                                        onTap: () {},
                                        onLongPress: () async {
                                          remove(
                                              snapshot.data!.docs[index].id,
                                              index,
                                              snapshot.data!.docs.length,
                                              snapshot.data!);
                                        },
                                        child: ReplyMessage(
                                            sendingdate: snapshot.data!
                                                .docs[index]["sending_date"],
                                            senderImagePath:
                                                widget.senderProfilePicturePath,
                                            isMe: true,
                                            name: myname,
                                            newMessage: snapshot
                                                .data!.docs[index]["message"],
                                            oldMessage: snapshot.data!
                                                .docs[index]["old_message"]),
                                      ),
                                    )
                                  : SwipeTo(
                                      onRightSwipe: () {
                                        messageFocusNode.requestFocus();
                                        setState(() {
                                          willReply = true;
                                          replyMessage = snapshot
                                              .data!.docs[index]["old_message"];
                                          whoWillReply = myname;
                                        });
                                      },
                                      iconColor: Colors.pinkAccent,
                                      child: GestureDetector(
                                        onTap: () {},
                                        onLongPress: () {
                                          remove(
                                              snapshot.data!.docs[index].id,
                                              index,
                                              snapshot.data!.docs.length,
                                              snapshot.data!);
                                        },
                                        child: ReplyMessage(
                                            sendingdate: snapshot.data!
                                                .docs[index]["sending_date"],
                                            senderImagePath:
                                                widget.senderProfilePicturePath,
                                            isMe: false,
                                            name: myname,
                                            newMessage: snapshot
                                                .data!.docs[index]["message"],
                                            oldMessage: snapshot.data!
                                                .docs[index]["old_message"]),
                                      ),
                                    );
                            } else if (snapshot.data!.docs[index]["type"] ==
                                "audio") {
                              return snapshot.data!.docs[index]["me"] ==
                                      widget.currentUserUid
                                  ? SwipeTo(
                                      onLeftSwipe: () {
                                        messageFocusNode.requestFocus();
                                        setState(() {
                                          willReply = true;
                                          replyMessage = "Voice Record";
                                          whoWillReply = myname;
                                        });
                                      },
                                      iconColor: Colors.pinkAccent,
                                      child: GestureDetector(
                                        onTap: () {},
                                        onLongPress: () async {
                                          remove(
                                              snapshot.data!.docs[index].id,
                                              index,
                                              snapshot.data!.docs.length,
                                              snapshot.data!);
                                        },
                                        child: VoiceRecord(
                                          sendingdate: snapshot.data!
                                              .docs[index]["sending_date"],
                                          senderImagePath:
                                              widget.senderProfilePicturePath,
                                          isMe: true,
                                          imageUrl: snapshot.data!.docs[index]
                                              ["message"],
                                        ),
                                      ),
                                    )
                                  : SwipeTo(
                                      onRightSwipe: () {
                                        messageFocusNode.requestFocus();
                                        setState(() {
                                          willReply = true;
                                          replyMessage = "Voice Record";
                                          whoWillReply = myname;
                                        });
                                      },
                                      iconColor: Colors.pinkAccent,
                                      child: GestureDetector(
                                        onTap: () {},
                                        onLongPress: () {
                                          remove(
                                              snapshot.data!.docs[index].id,
                                              index,
                                              snapshot.data!.docs.length,
                                              snapshot.data!);
                                        },
                                        child: VoiceRecord(
                                          sendingdate: snapshot.data!
                                              .docs[index]["sending_date"],
                                          senderImagePath:
                                              widget.senderProfilePicturePath,
                                          isMe: false,
                                          imageUrl: snapshot.data!.docs[index]
                                              ["message"],
                                        ),
                                      ),
                                    );
                            } else if (snapshot.data!.docs[index]["type"] ==
                                "image") {
                              return snapshot.data!.docs[index]["me"] ==
                                      widget.currentUserUid
                                  ? SwipeTo(
                                      onLeftSwipe: () {
                                        messageFocusNode.requestFocus();
                                        setState(() {
                                          willReply = true;
                                          replyMessage = "Picture";
                                          whoWillReply = myname;
                                        });
                                      },
                                      iconColor: Colors.pinkAccent,
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Stack(
                                                alignment:
                                                    AlignmentDirectional.topEnd,
                                                children: [
                                                  BackdropFilter(
                                                    filter: ImageFilter.blur(
                                                        sigmaX: 16, sigmaY: 16),
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      child: InteractiveViewer(
                                                          child: Center(
                                                        child: CachedNetworkImage(
                                                            imageUrl: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ["message"]),
                                                      )),
                                                    ),
                                                  ),
                                                  Material(
                                                    color: Colors.transparent,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          downloadStuff(
                                                              snapshot, index);
                                                        },
                                                        icon: const Icon(
                                                          Icons.cloud_download,
                                                          color: Colors.white,
                                                        )),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        onLongPress: () async {
                                          remove(
                                              snapshot.data!.docs[index].id,
                                              index,
                                              snapshot.data!.docs.length,
                                              snapshot.data!);
                                        },
                                        child: ImageShower(
                                          senderImagePath:
                                              widget.senderProfilePicturePath,
                                          sendingdate: snapshot.data!
                                              .docs[index]["sending_date"],
                                          isMe: true,
                                          imagePath: snapshot.data!.docs[index]
                                              ["message"],
                                        ),
                                      ),
                                    )
                                  : SwipeTo(
                                      onRightSwipe: () {
                                        messageFocusNode.requestFocus();
                                        setState(() {
                                          willReply = true;
                                          replyMessage = "Picture";
                                          whoWillReply = myname;
                                        });
                                      },
                                      iconColor: Colors.pinkAccent,
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 16, sigmaY: 16),
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: InteractiveViewer(
                                                      child: CachedNetworkImage(
                                                          imageUrl: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ["message"])),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        onLongPress: () async {
                                          remove(
                                              snapshot.data!.docs[index].id,
                                              index,
                                              snapshot.data!.docs.length,
                                              snapshot.data!);
                                        },
                                        child: ImageShower(
                                          senderImagePath:
                                              widget.senderProfilePicturePath,
                                          sendingdate: snapshot.data!
                                              .docs[index]["sending_date"],
                                          isMe: false,
                                          imagePath: snapshot.data!.docs[index]
                                              ["message"],
                                        ),
                                      ),
                                    );
                            } else if (snapshot.data!.docs[index]["type"]
                                .contains(RegExp(r"(document|music)"))) {
                              return snapshot.data!.docs[index]["me"] ==
                                      widget.currentUserUid
                                  ? SwipeTo(
                                      onLeftSwipe: () {
                                        messageFocusNode.requestFocus();
                                        setState(() {
                                          willReply = true;
                                          replyMessage = "File";
                                          whoWillReply = myname;
                                        });
                                      },
                                      iconColor: Colors.pinkAccent,
                                      child: GestureDetector(
                                        onTap: () async {
                                          try {
                                            downloadStuff(snapshot, index);
                                          } catch (e) {
                                            print(e);
                                          }
                                        },
                                        onLongPress: () async {
                                          remove(
                                              snapshot.data!.docs[index].id,
                                              index,
                                              snapshot.data!.docs.length,
                                              snapshot.data!);
                                        },
                                        child: FileShower(
                                          sendingdate: snapshot.data!
                                              .docs[index]["sending_date"],
                                          senderImagePath:
                                              widget.senderProfilePicturePath,
                                          downloadProgressValue:
                                              downloadProgressValue[index],
                                          isMe: true,
                                          type: snapshot
                                              .data!.docs[index]["message"]
                                              .split(" : ")[0]
                                              .substring(snapshot.data!
                                                      .docs[index]["message"]
                                                      .split(" : ")[0]
                                                      .lastIndexOf(".") +
                                                  1),
                                        ),
                                      ),
                                    )
                                  : SwipeTo(
                                      onRightSwipe: () {
                                        messageFocusNode.requestFocus();
                                        setState(() {
                                          willReply = true;
                                          replyMessage = "File";
                                          whoWillReply = myname;
                                        });
                                      },
                                      iconColor: Colors.pinkAccent,
                                      child: GestureDetector(
                                        onTap: () {
                                          try {
                                            downloadStuff(snapshot, index);
                                          } catch (e) {
                                            print(e);
                                          }
                                        },
                                        onLongPress: () {
                                          remove(
                                              snapshot.data!.docs[index].id,
                                              index,
                                              snapshot.data!.docs.length,
                                              snapshot.data!);
                                        },
                                        child: FileShower(
                                          sendingdate: snapshot.data!
                                              .docs[index]["sending_date"],
                                          senderImagePath:
                                              widget.senderProfilePicturePath,
                                          downloadProgressValue:
                                              downloadProgressValue[index],
                                          isMe: false,
                                          type: snapshot
                                              .data!.docs[index]["message"]
                                              .split(" : ")[0]
                                              .substring(snapshot.data!
                                                      .docs[index]["message"]
                                                      .split(" : ")[0]
                                                      .lastIndexOf(".") +
                                                  1),
                                        ),
                                      ),
                                    );
                            } else {
                              return snapshot.data!.docs[index]["me"] ==
                                      widget.currentUserUid
                                  ? SwipeTo(
                                      onLeftSwipe: () {
                                        messageFocusNode.requestFocus();
                                        setState(() {
                                          willReply = true;
                                          replyMessage = snapshot
                                              .data!.docs[index]["message"];
                                          whoWillReply = myname;
                                        });
                                      },
                                      iconColor: Colors.pinkAccent,
                                      child: GestureDetector(
                                        onLongPress: () async {
                                          remove(
                                              snapshot.data!.docs[index].id,
                                              index,
                                              snapshot.data!.docs.length,
                                              snapshot.data!);
                                        },
                                        child: ms.Message(
                                          sendingdate: snapshot.data!
                                              .docs[index]["sending_date"],
                                          senderImagePath:
                                              widget.senderProfilePicturePath,
                                          isMe: true,
                                          message: snapshot.data!.docs[index]
                                              ["message"],
                                        ),
                                      ),
                                    )
                                  : SwipeTo(
                                      onRightSwipe: () {
                                        messageFocusNode.requestFocus();
                                        setState(() {
                                          willReply = true;
                                          replyMessage = snapshot
                                              .data!.docs[index]["message"];
                                          whoWillReply = myname;
                                        });
                                      },
                                      iconColor: Colors.pinkAccent,
                                      child: GestureDetector(
                                        onLongPress: () {
                                          remove(
                                              snapshot.data!.docs[index].id,
                                              index,
                                              snapshot.data!.docs.length,
                                              snapshot.data!);
                                        },
                                        child: ms.Message(
                                          sendingdate: snapshot.data!
                                              .docs[index]["sending_date"],
                                          senderImagePath:
                                              widget.senderProfilePicturePath,
                                          isMe: false,
                                          message: snapshot.data!.docs[index]
                                              ["message"],
                                        ),
                                      ),
                                    );
                            }
                          },
                        ),
                        if (!isMax)
                          IconButton(
                            color: Colors.transparent,
                            onPressed: () {
                              scrollController.animateTo(
                                  scrollController.position.minScrollExtent,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.linear);
                              isMax = true;
                              setState(() {});
                            },
                            icon: const Icon(
                              FontAwesomeIcons.arrowDown,
                              color: Color.fromARGB(255, 17, 255, 0),
                              size: 18,
                            ),
                          ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            Column(
              children: [
                if (willReply)
                  Card(
                    color: const Color.fromARGB(255, 0, 47, 86),
                    child: ListTile(
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            willReply = false;
                          });
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          width: 4,
                          color: Colors.yellow,
                        ),
                      ),
                      title: Text(
                        whoWillReply,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        replyMessage,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                Container(
                  height: 50,
                  child: Card(
                    //surfaceTintColor: Colors.green,
                    //elevation: 8,
                    color: Colors.white.withOpacity(.4),
                    shape: const UnderlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              showEmoji = !showEmoji;
                            });
                          },
                          icon: const Icon(
                            Icons.emoji_emotions,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextField(
                              style: const TextStyle(color: Colors.white),
                              controller: messageController,
                              decoration: const InputDecoration(
                                hintText: "Message",
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                              //textCapitalization: TextCapitalization.words,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            filePickerResult = await FilePicker.platform
                                .pickFiles(
                                    allowMultiple: true,
                                    type: FileType.custom,
                                    allowedExtensions: [
                                  "txt",
                                  "xls",
                                  "pdf",
                                  "doc",
                                  "txt",
                                  "mp3",
                                  "mp4",
                                  "wav",
                                  "json",
                                  "xml"
                                ]);
                            if (filePickerResult != null) {
                              filePickerResult!.paths.map((path) async {
                                DateTime now = DateTime.now();
                                String type = "text";
                                String imageUrl = "";
                                if (path!
                                    .contains(RegExp(r".+\.(jpeg|jpg|png)"))) {
                                  type = "image";
                                } else if (path.contains(RegExp(
                                    r".+\.(pdf|json|xls|xml|doc|txt)"))) {
                                  type = "document";
                                } else if (path
                                    .contains(RegExp(r".+\.(mp3|wav)"))) {
                                  type = "music";
                                } else if (path
                                    .contains(RegExp(r".+\.(mp4)"))) {
                                  type = "video";
                                }
                                if (type.contains(RegExp(r"document|music"))) {
                                  String alpha = "";
                                  await FirebaseStorage.instance
                                      .ref(
                                          "data/${widget.currentUserUid}    ${widget.senderUid}/")
                                      .child(
                                          "${filePickerResult!.files.firstWhere((element) => element.path == path).name} : $now")
                                      .putFile(File(path))
                                      .then((p0) async => alpha =
                                          await p0.ref.getDownloadURL());

                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(widget.currentUserUid)
                                      .collection("messages")
                                      .doc(widget.senderUid)
                                      .collection("chats")
                                      .add(
                                    {
                                      "me": widget.currentUserUid,
                                      "sender": widget.senderUid,
                                      "message": path,
                                      "type": type,
                                      "message_date": now,
                                      "alphaurl": alpha,
                                      "sending_date":
                                          "${DateFormat.yMEd().add_yMMMMEEEEd().format(DateTime.now()).split(" ")[3].substring(0, 3)} ${DateFormat.yMEd().add_yMMMMEEEEd().format(DateTime.now()).split(" ")[1].split("/")[1]}, ${DateFormat.yMEd().add_Hms().format(DateTime.now()).split(" ")[2].split(":")[0]}:${DateFormat.yMEd().add_Hms().format(DateTime.now()).split(" ")[2].split(":")[1]}",
                                    },
                                  ).then(
                                    (value) async => await FirebaseFirestore
                                        .instance
                                        .collection("users")
                                        .doc(widget.currentUserUid)
                                        .collection("messages")
                                        .doc(widget.senderUid)
                                        .set(
                                      {
                                        "last_message": "$type was sent",
                                      },
                                    ),
                                  );
                                  if (widget.currentUserUid !=
                                      widget.senderUid) {
                                    await FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(widget.senderUid)
                                        .collection("messages")
                                        .doc(widget.currentUserUid)
                                        .collection("chats")
                                        .add(
                                      {
                                        "me": widget.currentUserUid,
                                        "sender": widget.senderUid,
                                        "message": path,
                                        "type": type,
                                        "message_date": now,
                                        "sending_date":
                                            "${DateFormat.yMEd().add_yMMMMEEEEd().format(DateTime.now()).split(" ")[3].substring(0, 3)} ${DateFormat.yMEd().add_yMMMMEEEEd().format(DateTime.now()).split(" ")[1].split("/")[1]}, ${DateFormat.yMEd().add_Hms().format(DateTime.now()).split(" ")[2].split(":")[0]}:${DateFormat.yMEd().add_Hms().format(DateTime.now()).split(" ")[2].split(":")[1]}",
                                      },
                                    ).then(
                                      (value) async => await FirebaseFirestore
                                          .instance
                                          .collection("users")
                                          .doc(widget.senderUid)
                                          .collection("messages")
                                          .doc(widget.currentUserUid)
                                          .set(
                                        {
                                          "last_message": "$type was sent",
                                        },
                                      ),
                                    );
                                  }
                                } else {
                                  await FirebaseStorage.instance
                                      .ref(
                                          "data/${widget.currentUserUid}    ${widget.senderUid}/")
                                      .child(
                                          "${filePickerResult!.files.firstWhere((element) => element.path == path).name} : $now")
                                      .putFile(File(path))
                                      .then((TaskSnapshot fileref) async =>
                                          imageUrl = await fileref.ref
                                              .getDownloadURL());

                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(widget.currentUserUid)
                                      .collection("messages")
                                      .doc(widget.senderUid)
                                      .collection("chats")
                                      .add(
                                    {
                                      "me": widget.currentUserUid,
                                      "sender": widget.senderUid,
                                      "message": imageUrl,
                                      "type": type,
                                      "message_date": now,
                                      "sending_date":
                                          "${DateFormat.yMEd().add_yMMMMEEEEd().format(DateTime.now()).split(" ")[3].substring(0, 3)} ${DateFormat.yMEd().add_yMMMMEEEEd().format(DateTime.now()).split(" ")[1].split("/")[1]}, ${DateFormat.yMEd().add_Hms().format(DateTime.now()).split(" ")[2].split(":")[0]}:${DateFormat.yMEd().add_Hms().format(DateTime.now()).split(" ")[2].split(":")[1]}",
                                    },
                                  ).then(
                                    (value) async => await FirebaseFirestore
                                        .instance
                                        .collection("users")
                                        .doc(widget.currentUserUid)
                                        .collection("messages")
                                        .doc(widget.senderUid)
                                        .set(
                                      {
                                        "last_message": "$type was sent",
                                      },
                                    ),
                                  );
                                  if (widget.currentUserUid !=
                                      widget.senderUid) {
                                    await FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(widget.senderUid)
                                        .collection("messages")
                                        .doc(widget.currentUserUid)
                                        .collection("chats")
                                        .add(
                                      {
                                        "me": widget.currentUserUid,
                                        "sender": widget.senderUid,
                                        "message": imageUrl,
                                        "type": type,
                                        "message_date": now,
                                        "sending_date":
                                            "${DateFormat.yMEd().add_yMMMMEEEEd().format(DateTime.now()).split(" ")[3].substring(0, 3)} ${DateFormat.yMEd().add_yMMMMEEEEd().format(DateTime.now()).split(" ")[1].split("/")[1]}, ${DateFormat.yMEd().add_Hms().format(DateTime.now()).split(" ")[2].split(":")[0]}:${DateFormat.yMEd().add_Hms().format(DateTime.now()).split(" ")[2].split(":")[1]}",
                                      },
                                    ).then(
                                      (value) async => await FirebaseFirestore
                                          .instance
                                          .collection("users")
                                          .doc(widget.senderUid)
                                          .collection("messages")
                                          .doc(widget.currentUserUid)
                                          .set(
                                        {
                                          "last_message": "$type was sent",
                                        },
                                      ),
                                    );
                                  }
                                }
                              }).toList();
                              Fluttertoast.showToast(
                                msg: "Uploading",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.greenAccent,
                                textColor: Colors.white,
                              );
                              AssetsAudioPlayer.newPlayer()
                                  .open(Audio("assets/messagesent.mp3"));
                              if (widget.status == "Online" &&
                                  widget.currentUserUid != widget.senderUid) {
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(widget.senderUid)
                                    .get()
                                    .then((value2) => sendPushNotificationFCM(
                                          token: value2.get("token"),
                                          username: myname,
                                          message: "sent your an attachment",
                                        ));
                              }
                            } else {
                              Fluttertoast.showToast(
                                msg: "Canceled",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.greenAccent,
                                textColor: Colors.white,
                              );
                            }
                          },
                          icon: const Icon(
                            FontAwesomeIcons.arrowRightFromBracket,
                            color: Colors.greenAccent,
                            size: 16,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            if (recorder.isRecording) {
                              final path = await stop();
                              String? audioref;
                              DateTime now = DateTime.now();
                              await FirebaseStorage.instance
                                  .ref(
                                      "data/${widget.currentUserUid}    ${widget.senderUid}/")
                                  .child(path.split("/").last)
                                  .putFile(File(path))
                                  .then((TaskSnapshot fileref) async =>
                                      audioref =
                                          await fileref.ref.getDownloadURL());

                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(widget.currentUserUid)
                                  .collection("messages")
                                  .doc(widget.senderUid)
                                  .collection("chats")
                                  .add(
                                {
                                  "me": widget.currentUserUid,
                                  "sender": widget.senderUid,
                                  "message": audioref!,
                                  "type": "audio",
                                  "message_date": now,
                                  "sending_date":
                                      "${DateFormat.yMEd().add_yMMMMEEEEd().format(DateTime.now()).split(" ")[3].substring(0, 3)} ${DateFormat.yMEd().add_yMMMMEEEEd().format(DateTime.now()).split(" ")[1].split("/")[1]}, ${DateFormat.yMEd().add_Hms().format(DateTime.now()).split(" ")[2].split(":")[0]}:${DateFormat.yMEd().add_Hms().format(DateTime.now()).split(" ")[2].split(":")[1]}",
                                },
                              ).then(
                                (value) async => await FirebaseFirestore
                                    .instance
                                    .collection("users")
                                    .doc(widget.currentUserUid)
                                    .collection("messages")
                                    .doc(widget.senderUid)
                                    .set(
                                  {
                                    "last_message": "a voice record was sent",
                                  },
                                ),
                              );
                              if (widget.currentUserUid != widget.senderUid) {
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(widget.senderUid)
                                    .collection("messages")
                                    .doc(widget.currentUserUid)
                                    .collection("chats")
                                    .add(
                                  {
                                    "me": widget.currentUserUid,
                                    "sender": widget.senderUid,
                                    "message": audioref,
                                    "type": "audio",
                                    "message_date": now,
                                    "sending_date":
                                        "${DateFormat.yMEd().add_yMMMMEEEEd().format(DateTime.now()).split(" ")[3].substring(0, 3)} ${DateFormat.yMEd().add_yMMMMEEEEd().format(DateTime.now()).split(" ")[1].split("/")[1]}, ${DateFormat.yMEd().add_Hms().format(DateTime.now()).split(" ")[2].split(":")[0]}:${DateFormat.yMEd().add_Hms().format(DateTime.now()).split(" ")[2].split(":")[1]}",
                                  },
                                ).then(
                                  (value) async => await FirebaseFirestore
                                      .instance
                                      .collection("users")
                                      .doc(widget.senderUid)
                                      .collection("messages")
                                      .doc(widget.currentUserUid)
                                      .set(
                                    {
                                      "last_message": "a voice record was sent",
                                    },
                                  ),
                                );
                              }

                              AssetsAudioPlayer.newPlayer()
                                  .open(Audio.network(path));
                              Fluttertoast.showToast(
                                msg: "Uploading Voice Record",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.redAccent,
                                textColor: Colors.white,
                              );
                              if (widget.status == "Online" &&
                                  widget.currentUserUid != widget.senderUid) {
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(widget.senderUid)
                                    .get()
                                    .then((value2) => sendPushNotificationFCM(
                                          token: value2.get("token"),
                                          username: myname,
                                          message: 'zent you a voice record',
                                        ));
                              }
                            } else {
                              await record();
                            }
                          },
                          icon: Icon(
                            recorder.isRecording
                                ? FontAwesomeIcons.stop
                                : FontAwesomeIcons.microphone,
                            color: Colors.red,
                            size: 16,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            //print(FirebaseAuth.instance.currentUser!.metadata.creationTime ||FirebaseAuth.instance.currentUser!.metadata.lastSignInTime);
                            String messageText = messageController.text.trim();
                            messageController.clear();
                            DateTime now = DateTime.now();
                            if (!messageText.contains(RegExp(r"^\s*$"))) {
                              scrollController.jumpTo(
                                  scrollController.position.minScrollExtent);
                              if (!willReply) {
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(widget.currentUserUid)
                                    .collection("messages")
                                    .doc(widget.senderUid)
                                    .collection("chats")
                                    .add(
                                  {
                                    "me": widget.currentUserUid,
                                    "sender": widget.senderUid,
                                    "message": messageText,
                                    "type": "text",
                                    "message_date": now,
                                    "sending_date":
                                        "${DateFormat.yMEd().add_yMMMMEEEEd().format(DateTime.now()).split(" ")[3].substring(0, 3)} ${DateFormat.yMEd().add_yMMMMEEEEd().format(DateTime.now()).split(" ")[1].split("/")[1]}, ${DateFormat.yMEd().add_Hms().format(DateTime.now()).split(" ")[2].split(":")[0]}:${DateFormat.yMEd().add_Hms().format(DateTime.now()).split(" ")[2].split(":")[1]}",
                                  },
                                ).then(
                                  (value) async => await FirebaseFirestore
                                      .instance
                                      .collection("users")
                                      .doc(widget.currentUserUid)
                                      .collection("messages")
                                      .doc(widget.senderUid)
                                      .set(
                                    {
                                      "last_message": messageText,
                                    },
                                  ),
                                );

                                //time format must be the same !!
                                if (widget.currentUserUid != widget.senderUid) {
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(widget.senderUid)
                                      .collection("messages")
                                      .doc(widget.currentUserUid)
                                      .collection("chats")
                                      .add(
                                    {
                                      "me": widget.currentUserUid,
                                      "sender": widget.senderUid,
                                      "message": messageText,
                                      "type": "text",
                                      "message_date": now,
                                      "sending_date":
                                          "${DateFormat.yMEd().add_yMMMMEEEEd().format(DateTime.now()).split(" ")[3].substring(0, 3)} ${DateFormat.yMEd().add_yMMMMEEEEd().format(DateTime.now()).split(" ")[1].split("/")[1]}, ${DateFormat.yMEd().add_Hms().format(DateTime.now()).split(" ")[2].split(":")[0]}:${DateFormat.yMEd().add_Hms().format(DateTime.now()).split(" ")[2].split(":")[1]}",
                                    },
                                  ).then(
                                    (value) async => await FirebaseFirestore
                                        .instance
                                        .collection("users")
                                        .doc(widget.senderUid)
                                        .collection("messages")
                                        .doc(widget.currentUserUid)
                                        .set(
                                      {
                                        "last_message": messageText,
                                      },
                                    ),
                                  );
                                }
                              } else {
                                if (widget.status == "Online" &&
                                    widget.currentUserUid != widget.senderUid) {
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(widget.senderUid)
                                      .get()
                                      .then((value2) => sendPushNotificationFCM(
                                            token: value2.get("token"),
                                            username: myname,
                                            message:
                                                'Replied to your message : $messageText',
                                          ));
                                }
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(widget.currentUserUid)
                                    .collection("messages")
                                    .doc(widget.senderUid)
                                    .collection("chats")
                                    .add(
                                  {
                                    "me": widget.currentUserUid,
                                    "sender": widget.senderUid,
                                    "message": messageText,
                                    "type": "reply",
                                    "message_date": now,
                                    "old_message": replyMessage,
                                    "sending_date":
                                        "${DateFormat.yMEd().add_yMMMMEEEEd().format(DateTime.now()).split(" ")[3].substring(0, 3)} ${DateFormat.yMEd().add_yMMMMEEEEd().format(DateTime.now()).split(" ")[1].split("/")[1]}, ${DateFormat.yMEd().add_Hms().format(DateTime.now()).split(" ")[2].split(":")[0]}:${DateFormat.yMEd().add_Hms().format(DateTime.now()).split(" ")[2].split(":")[1]}",
                                  },
                                ).then(
                                  (value) async => await FirebaseFirestore
                                      .instance
                                      .collection("users")
                                      .doc(widget.currentUserUid)
                                      .collection("messages")
                                      .doc(widget.senderUid)
                                      .set(
                                    {
                                      "last_message": messageText,
                                    },
                                  ),
                                );

                                //time format must be the same !!
                                if (widget.currentUserUid != widget.senderUid) {
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(widget.senderUid)
                                      .collection("messages")
                                      .doc(widget.currentUserUid)
                                      .collection("chats")
                                      .add(
                                    {
                                      "me": widget.currentUserUid,
                                      "sender": widget.senderUid,
                                      "message": messageText,
                                      "type": "reply",
                                      "message_date": now,
                                      "old_message": replyMessage,
                                      "sending_date":
                                          "${DateFormat.yMEd().add_yMMMMEEEEd().format(DateTime.now()).split(" ")[3].substring(0, 3)} ${DateFormat.yMEd().add_yMMMMEEEEd().format(DateTime.now()).split(" ")[1].split("/")[1]}, ${DateFormat.yMEd().add_Hms().format(DateTime.now()).split(" ")[2].split(":")[0]}:${DateFormat.yMEd().add_Hms().format(DateTime.now()).split(" ")[2].split(":")[1]}",
                                    },
                                  ).then(
                                    (value) async => await FirebaseFirestore
                                        .instance
                                        .collection("users")
                                        .doc(widget.senderUid)
                                        .collection("messages")
                                        .doc(widget.currentUserUid)
                                        .set(
                                      {
                                        "last_message": messageText,
                                      },
                                    ),
                                  );
                                }
                                willReply = false;
                              }
                              if (widget.status == "Online" &&
                                  widget.currentUserUid != widget.senderUid) {
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(widget.senderUid)
                                    .get()
                                    .then((value2) => sendPushNotificationFCM(
                                          token: value2.get("token"),
                                          username: myname,
                                          message: messageText,
                                        ));
                              }
                              AssetsAudioPlayer.newPlayer()
                                  .open(Audio("assets/messagesent.mp3"));
                            }
                          },
                          icon: const Icon(
                            FontAwesomeIcons.solidPaperPlane,
                            color: Colors.blueAccent,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (showEmoji)
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: EmojiPicker(
                    config: const Config(
                      columns: 7,
                      emojiSizeMax: 20,
                      verticalSpacing: 1,
                      horizontalSpacing: 1,
                      gridPadding: EdgeInsets.all(8.0),
                      initCategory: Category.RECENT,
                      bgColor: Colors.transparent,
                      indicatorColor: Colors.pinkAccent,
                      iconColor: Colors.grey,
                      iconColorSelected: Colors.greenAccent,
                      progressIndicatorColor: Colors.amber,
                      backspaceColor: Colors.blueAccent,
                      replaceEmojiOnLimitExceed: true,
                    ),
                    onEmojiSelected: (category, emoji) {
                      setState(() {
                        messageController.text += emoji.emoji;
                        messageController.selection = TextSelection(
                            baseOffset: messageController.text.length,
                            extentOffset: messageController.text.length);
                      });
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future record() async {
    await recorder.startRecorder(
        toFile:
            '${DateTime.now().toString().replaceAll(RegExp(r"(\-|:| |\.)"), "")} voice');
    Fluttertoast.showToast(
      msg: "Recording Started",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color.fromARGB(255, 136, 255, 0),
      textColor: Colors.white,
    );
  }

  Future<String> stop() async {
    final path = await recorder.stopRecorder();
    Fluttertoast.showToast(
      msg: "Recording Stopped",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color.fromARGB(255, 136, 255, 0),
      textColor: Colors.white,
    );
    return path!;
  }

  void downloadStuff(snapshot, index) async {
    Reference? ref;
    await FirebaseStorage.instance
        .ref("data/${widget.currentUserUid}    ${widget.senderUid}")
        .listAll()
        .then((value) => ref = value.items.firstWhere((element) => snapshot
            .data!.docs[index]["message"]
            .contains(element.name.split(" : ")[0])));
    final url = await ref!.getDownloadURL();
    final tempdir = await getTemporaryDirectory();
    await Dio().download(
      url,
      "${tempdir.path}/${ref!.name}",
      onReceiveProgress: (count, total) {
        setState(() {
          downloadProgressValue[index] = count / total;
        });
      },
    );

    /* if (url.contains(RegExp(r"(mp3|wav)"))) {
      await GallerySaver.saveVideo("${tempdir.path}/${ref!.name}");
    } else*/
    if (url.contains(RegExp(r"(jpg|png|jpeg)"))) {
      await GallerySaver.saveImage("${tempdir.path}/${ref!.name}");
    }
    /* only this app can access the file
                                            final dir =
                                                await getApplicationSupportDirectory();
                                            final file = File(
                                                "${dir.path}/${ref!.name}");
                                            await ref!.writeToFile(file);*/
    Fluttertoast.showToast(
      msg: "Downloaded",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color.fromARGB(255, 16, 109, 190),
      textColor: Colors.white,
    );
  }
}
