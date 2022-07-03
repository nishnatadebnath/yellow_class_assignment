import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:yellow_class/model/Video.dart';
import 'package:yellow_class/video_widget.dart';

class PostContainer extends StatefulWidget {
  const PostContainer({
    required this.id,
    Key? key,
  }) : super(key: key);
  final Video id;

  @override
  PostContainerState createState() => PostContainerState();
}

class PostContainerState extends State<PostContainer> {
  bool startedPlaying = false;
  bool inView = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final PageController controller = PageController(initialPage: 0);
  int pindex = 0;
  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.id.id.toString()),
      onVisibilityChanged: (info) {
        info.visibleFraction > 0.5 ? inView = true : inView = false;
        setState(() {});
      },
      child: Stack(children: [
        PageView(
          scrollDirection: Axis.horizontal,
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              pindex = index;
              inView = pindex == 0;
            });
          },
          children: List.generate(
            4,
            (index) => index == 0
                ? Center(
                    child: VideoWidget(url: widget.id.videoUrl, play: inView))
                : Image(
                    image: NetworkImage(widget.id.coverPicture),
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 100.0, vertical: 10.0),
                child: Row(
                  children: [
                    for (int i = 0; i < 4; i++)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Divider(
                            thickness: 3.0,
                            color: pindex == i
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                          ),
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
