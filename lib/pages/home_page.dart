import 'dart:convert';

import 'package:alan_voice/alan_voice.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/drawer.dart';
import 'package:flutter_application_1/utils/ai_utils.dart';
import 'package:velocity_x/velocity_x.dart';

import '../model/radio.dart';

class AppColors {
  static const Color PrimaryColor = Color.fromRGBO(228, 237, 242, 1);
  static const Color PrimaryColor5 = Color.fromRGBO(205, 226, 238, 1);
  static const Color PrimaryColor1 = Color.fromRGBO(187, 220, 240, 1);
  static const Color PrimaryColor2 = Color.fromRGBO(168, 218, 249, 1);
  static const Color PrimaryColor3 = Color.fromRGBO(146, 210, 249, 1);
  static const Color PrimaryColor4 = Color.fromRGBO(1, 31, 75, 1);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MyRadio _selectedRadio = MyRadio(
      id: 1,
      name: "92.7",
      tagline: "Suno Sunao, Life Banao!",
      color: "0xffa11431",
      desc:
          "The chills you get when you listen to music, is mostly caused by the brain releasing dopamine while anticipating the peak moment of a song.",
      url: "http://mediaserv30.live-streams.nl:8086/live",
      icon:
          "https://mytuner.global.ssl.fastly.net/media/tvos_radios/m8afyszryaqt.png",
      image:
          "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/b5df4c18876369.562d0d4bd94cf.jpg",
      lang: "Hindi",
      category: "pop",
      order: 1); // Initialize with a default value

  Color? _selectedColor = Colors.black; // Initialize with a default color
  bool _isPlaying = false;
  final sugg = [
    "play",
    "Stop",
    "Play rock music",
    "Play 107 FM",
    "Play next"
        "Play 104 FM",
    "Pause",
    "Play Previous",
    "Play pop music"
  ];
  final AudioPlayer _audioplayer = AudioPlayer();
  List<MyRadio>? radios = [
    MyRadio(
        id: 1,
        order: 1,
        name: "name",
        tagline: "tagline",
        color: "color",
        desc: "desc",
        url: "url",
        category: "category",
        icon: "icon",
        image: "image",
        lang: "lang")
  ];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    if (!kIsWeb) {
      setupAlan();
    }
    fetchRadios();
    _audioplayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.playing) {
        _isPlaying = true;
      } else {
        _isPlaying = false;
      }
      setState(() {});
    });
  }

  setupAlan() {
    AlanVoice.addButton(
        "e9dcb1a440267f5d725c71e312ea46da2e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);
    print("Inside alan");
    AlanVoice.callbacks.add((command) => _handleCommand(command.data));
  }

  handleAlanCommand(String command) {
    Map<String, dynamic> response = json.decode(command);
    _handleCommand(response);
  }

  _handleCommand(Map<String, dynamic> response) {
    print("Insisde switch of handle command");

    switch (response["command"]) {
      case "play":
        _playMusic(_selectedRadio.url);
        break;
      case "play_music":
        final id = response["id"];
        _audioplayer.pause();
        MyRadio newRadio = radios!.firstWhere((element) => element.id == id);
        radios!.remove(newRadio);
        radios!.insert(0, newRadio);
        _playMusic(newRadio.url);
      case "stop":
        _audioplayer.stop();
        break;
      case "next":
        final index = _selectedRadio.id;
        MyRadio newRadio;
        if (index + 1 > radios!.length) {
          newRadio = radios!.firstWhere((element) => element.id == 1);
          radios!.remove(newRadio);
          radios!.insert(0, newRadio);
        } else {
          newRadio = radios!.firstWhere((element) => element.id == index + 1);
          radios!.remove(newRadio);
          radios!.insert(0, newRadio);
        }
        _playMusic(newRadio.url);
        break;
      case "prev":
        final index = _selectedRadio.id;
        MyRadio newRadio;
        if (index - 1 <= 0) {
          newRadio = radios!.firstWhere((element) => element.id == 1);
          radios!.remove(newRadio);
          radios!.insert(0, newRadio);
        } else {
          newRadio = radios!.firstWhere((element) => element.id == index - 1);
          radios!.remove(newRadio);
          radios!.insert(0, newRadio);
        }
        _playMusic(newRadio.url);
        break;

      default:
        print("Comaand was ${response["command"]}");
        break;
    }
  }

  void fetchRadios() async {
    final radioJson = await rootBundle.loadString("assets/radio.json");
    // print(radioJson);
    radios = MyRadioList?.fromJson(radioJson).radios;
    _selectedRadio = radios![0];
    _selectedColor = Color(int.tryParse(_selectedRadio.color)!);

    setState(() {});
  }

  _playMusic(String url) {
    _audioplayer.play(AssetSource("assets/music/sad.mp3"));
    _selectedRadio = radios!.firstWhere(
      (item) => item.url == url,
    );
    print(_selectedRadio.name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;

    return Scaffold(
      drawer: const CustomDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Builder(builder: (context) {
            return VxAnimatedBox()
                .size(screenWidth, screenHeight)
                .withGradient(LinearGradient(
                  colors: [
                    AIColors.primaryColor1,
                    _selectedColor ?? AIColors.primaryColor2,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ))
                .make();
          }),
          SingleChildScrollView(
            child: [
              AppBar(
                title: "AI Radio".text.xl4.bold.white.make().shimmer(
                    primaryColor: Vx.purple300, secondaryColor: Colors.white),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ).h(screenHeight * 0.1).p12(),
              SizedBox(height: screenHeight * 0.01),
              "Start with - Hey Alan".text.italic.semiBold.white.make(),
              SizedBox(height: screenHeight * 0.01),
              VxSwiper.builder(
                  itemCount: sugg.length,
                  height: screenHeight * 0.05,
                  viewportFraction: 0.35,
                  autoPlay: true,
                  autoPlayAnimationDuration: const Duration(seconds: 3),
                  autoPlayCurve: Curves.linear,
                  enableInfiniteScroll: true,
                  itemBuilder: (context, index) {
                    final s = sugg[index];
                    return Chip(
                      label: s.text.make(),
                      backgroundColor: Vx.randomColor,
                    );
                  }),
              SizedBox(height: screenHeight * 0.02),
              VxSwiper.builder(
                  itemCount: radios != null ? radios!.length : 0,
                  aspectRatio: kIsWeb ? 1.0 : 1.0,
                  scrollDirection: Axis.horizontal,
                  enlargeCenterPage: true,
                  height: kIsWeb ? screenHeight * 0.56 : screenHeight * 0.56,
                  onPageChanged: (index) {
                    _selectedRadio = radios![index];
                    final colorHex = radios![index].color;
                    _selectedColor = Color(int.tryParse(colorHex)!);
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    final rad = radios![index];

                    return VxBox(
                            child: ZStack(
                      [
                        Positioned(
                          top: 0.0,
                          right: 0.0,
                          child: VxBox(
                                  child: rad.category.text.bold.uppercase.white
                                      .make()
                                      .px16())
                              .height(screenHeight * 0.035)
                              .black
                              .alignCenter
                              .withRounded(value: 10.0)
                              .make(),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: VStack(
                            [
                              rad.name.text.white.bold.make(),
                              SizedBox(height: screenHeight * 0.005),
                              rad.tagline.text.sm.white.semiBold.make(),
                            ],
                            crossAlignment: CrossAxisAlignment.center,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: [
                            const Icon(
                              CupertinoIcons.play_circle,
                              color: Colors.white,
                              size: 51.0,
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            "Double Tap to Play".text.bold.gray300.make(),
                          ].vStack(),
                        )
                      ],
                      clip: Clip.antiAlias,
                    ))
                        .clip(Clip.antiAlias)
                        .bgImage(
                          DecorationImage(
                            image: NetworkImage(rad.image),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.3),
                                BlendMode.darken),
                          ),
                        )
                        .border(color: Colors.black, width: 5.0)
                        .withRounded(value: 60.0)
                        .make()
                        .onDoubleTap(() {
                      _playMusic(rad.url);
                    }).p16();
                  }).centered(),
              Container(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.04, bottom: screenHeight * 0.05),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: [
                    if (_isPlaying)
                      "Playing Now - ${_selectedRadio.name} FM"
                          .text
                          .white
                          .makeCentered(),
                    Icon(
                      _isPlaying
                          ? CupertinoIcons.stop_circle
                          : CupertinoIcons.play_circle,
                      color: Colors.white,
                      size: 60.0,
                    ).onTap(() {
                      if (_isPlaying) {
                        _audioplayer.stop();
                      } else {
                        print(_selectedRadio.url);
                        _playMusic(_selectedRadio.url);
                      }
                    }),
                    if (_isPlaying) "Tap To Stop".text.white.makeCentered(),
                    if (!_isPlaying)
                      "Double Tap To Play".text.white.makeCentered(),
                  ].vStack(),
                ),
              ),
            ].vStack(),
          ),
        ],
      ),
    );
  }
}
