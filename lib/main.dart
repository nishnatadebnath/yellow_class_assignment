import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yellow_class/model/Video.dart';
import 'package:yellow_class/video_widget.dart';
import 'flick_multi_player.dart';
import 'flick_video_player.dart';
import 'model/Video.dart';
import 'services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Video> _videos;
  late bool _loading;
  late FlickMultiManager flickMultiManager;

  @override
  void initState() {
    super.initState();
    _loading = true;
    Services.getVideo().then((Video) {
      setState(() {
        _videos = Video;
        _loading = false;
      });
      flickMultiManager = FlickMultiManager();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          _loading ? 'Loading...' : 'Yellow Class',
          style: const TextStyle(color: Colors.yellow),
        ),
      ),
      body: Container(
        //color: Colors.white,
        child: ListView.builder(
          itemCount: null == _videos ? 0 : 4,
          itemBuilder: (context, index) {
            Video user = _videos[index];
            return Container(
              margin: const EdgeInsets.all(10),
              color: Colors.white,
              child: FlickMultiPlayer(
                url: user.videoUrl,
                flickMultiManager: flickMultiManager,
                image: user.coverPicture,
              ),
            );
          },
        ),
      ),
    );
  }
}
