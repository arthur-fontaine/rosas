import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:rosas/widgets/CustomTrackShape.dart';
import 'package:rosas/models/ParsedFeed.dart';
import 'package:share/share.dart';
import 'package:webfeed/webfeed.dart';

Duration parseDuration(String s) {
  int hours = 0;
  int minutes = 0;
  int micros;
  List<String> parts = s.split(':');
  if (parts.length > 2) {
    hours = int.parse(parts[parts.length - 3]);
  }
  if (parts.length > 1) {
    minutes = int.parse(parts[parts.length - 2]);
  }
  micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
  return Duration(hours: hours, minutes: minutes, microseconds: micros);
}

class Player extends StatefulWidget {
  Player({Key key, this.playing, this.coverUrl}) : super(key: key);

  final RssItem playing;
  final String coverUrl;

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  bool loadPoadcast = true;
  Duration currentTime = Duration(seconds: 0);

  @override
  Widget build(BuildContext context) {
    if (loadPoadcast) {
      assetsAudioPlayer.open(
          Audio.network(
            widget.playing.enclosure.url.replaceFirst('http://', 'https://'),
            metas: Metas(
              image: MetasImage.network(widget.coverUrl),
              artist: widget.playing.itunes.author,
              title: widget.playing.title,
            ),
          ),
          showNotification: true,
          autoStart: false);

      assetsAudioPlayer.currentPosition.listen((positionValue) {
        if (positionValue.inSeconds ==
            widget.playing.itunes.duration.inSeconds) {}
        setState(() {
          currentTime = positionValue;
        });
      });

      setState(() {
        loadPoadcast = false;
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // ? Header of the player
            Container(
              height: 363,
              child: Stack(
                children: [
                  // ? Cover of the music
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.coverUrl),
                      ),
                    ),
                  ),
                  // Image.network(playing.imageUrl),
                  // ? Gradient
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.transparent]),
                    ),
                  ),
                  // ? Bar of the player
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ? Close button
                      IconButton(
                          icon: new Icon(Icons.close_rounded),
                          color: Colors.white,
                          onPressed: () {
                            assetsAudioPlayer.stop();
                            Navigator.pop(context);
                          }),
                      // ? Share button + Save button
                      Row(
                        children: [
                          // ? Share button
                          IconButton(
                              icon: new Icon(Icons.share_outlined),
                              color: Colors.white,
                              onPressed: () {
                                Share.share(widget.playing.link);
                              }),
                          // ? Save button
                          IconButton(
                              icon: new Icon(Icons.bookmark_outline_rounded),
                              color: Colors.white,
                              onPressed: () {}),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            // ? Body of the player
            Container(
              margin: EdgeInsets.only(top: (363 - 25).toDouble()),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 239, 250, 251),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Expanded(child: GestureDetector(
                        onDoubleTap: () {
                          assetsAudioPlayer.seekBy(Duration(seconds: -5));
                        },
                      )),
                      Expanded(child: GestureDetector(
                        onDoubleTap: () {
                          assetsAudioPlayer.seekBy(Duration(seconds: 5));
                        },
                      ))
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 25, top: 25, right: 25, bottom: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ? Author + Title
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ? Author
                            Container(
                                margin: EdgeInsets.only(bottom: 12.5),
                                child: Row(
                                  children: [
                                    Text(
                                      widget.playing.itunes.author,
                                      style: TextStyle(
                                        fontSize: 12.8,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                )),
                            // ? Title
                            Text(
                              widget.playing.title,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        // ? Controls
                        Column(
                          children: [
                            // ? Play bar + Duration
                            Container(
                                margin: EdgeInsets.only(
                                    left: 25, right: 25, bottom: 25),
                                child: Row(
                                  children: [
                                    SliderTheme(
                                        data: SliderThemeData(
                                          thumbColor: Colors.black,
                                          trackHeight: 4.0,
                                          trackShape: CustomTrackShape(),
                                          thumbShape: RoundSliderThumbShape(
                                              enabledThumbRadius: 7),
                                          activeTrackColor: Colors.black,
                                          inactiveTrackColor: Colors.black,
                                        ),
                                        child: Expanded(
                                            child: Slider(
                                                min: 0,
                                                max: widget.playing.itunes
                                                    .duration.inSeconds
                                                    .toDouble(),
                                                divisions: widget.playing.itunes
                                                    .duration.inSeconds
                                                    .toInt(),
                                                value: currentTime.inSeconds
                                                    .toDouble(),
                                                // label:
                                                //     "${playing.currentTime.inSeconds ~/ 60}:${(playing.currentTime.inSeconds % 60).toString().padLeft(2, '0')}",
                                                onChanged: (duration) {
                                                  assetsAudioPlayer.seek(
                                                      Duration(
                                                          seconds: duration
                                                              .toInt()));
                                                  setState(() {
                                                    currentTime = Duration(
                                                        seconds:
                                                            duration.toInt());
                                                  });
                                                }))),
                                    Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                            // "${playing.totalTime.inSeconds ~/ 60}:${(playing.totalTime.inSeconds % 60).toString().padLeft(2, '0')}"
                                            "${currentTime.inSeconds ~/ 60}:${(currentTime.inSeconds % 60).toString().padLeft(2, '0')}"))
                                  ],
                                )),
                            // ? Play button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(12.5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black),
                                  child: IconButton(
                                    icon: assetsAudioPlayer
                                            .isPlaying.valueWrapper.value
                                        ? new Icon(Icons.pause_rounded)
                                        : new Icon(Icons.play_arrow_rounded),
                                    color: Colors.white,
                                    iconSize: 40,
                                    onPressed: () {
                                      assetsAudioPlayer.playOrPause();
                                    },
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
