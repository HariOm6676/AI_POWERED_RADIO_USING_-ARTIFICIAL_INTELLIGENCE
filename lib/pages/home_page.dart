import 'package:alan_voice/alan_voice.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/utils/ai_utils.dart';
import 'package:velocity_x/velocity_x.dart';

import '../model/radio.dart';

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
  final sugg=[
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
    setupAlan();
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
        AlanVoice.callbacks.add((command)=>_handleCommand(command.data));
  }
  _handleCommand(Map<String,dynamic> response){
    switch (response["command"]){
      case "play":
        _playMusic(_selectedRadio.url);
        break;
      case "play_music":
        final id=response["id"];
        _audioplayer.pause();
        MyRadio newRadio=radios!.firstWhere((element)=>element.id==id);
            radios!.remove(newRadio);
            radios!.insert(0,newRadio);
        _playMusic(newRadio.url);
      case "stop":
        _audioplayer.stop();
        break;
      case "next":
        final index=_selectedRadio.id;
        MyRadio newRadio;
        if (index+1>radios!.length ){
            newRadio=radios!.firstWhere((element)=>element.id==1);
            radios!.remove(newRadio);
            radios!.insert(0,newRadio);
        }
        else{
          newRadio=radios!.firstWhere((element)=>element.id==index+1);
            radios!.remove(newRadio);
            radios!.insert(0,newRadio);
        }
        _playMusic(newRadio.url);
        break;
      case "prev":
        final index=_selectedRadio.id;
        MyRadio newRadio;
        if (index-1<=0){
            newRadio=radios!.firstWhere((element)=>element.id==1);
            radios!.remove(newRadio);
            radios!.insert(0,newRadio);
        }
        else{
          newRadio=radios!.firstWhere((element)=>element.id==index-1);
            radios!.remove(newRadio);
            radios!.insert(0,newRadio);
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
    _selectedRadio=radios![0];
    _selectedColor=Color(int.tryParse(_selectedRadio.color)!);


    setState(() {});
  }

  _playMusic(String url) {
    _audioplayer.play(UrlSource(url));
    _selectedRadio = radios!.firstWhere(
      (item) => item.url == url,
    );
    print(_selectedRadio.name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        drawer: Drawer(
          child: Container(
            
            color: _selectedColor??AIColors.primaryColor2,
            child: radios!=null
            ?[
              100.heightBox,
              "All Channels".text.xl.white.semiBold.make().px16(),
              20.heightBox,
              ListView(
                padding: Vx.m0,
                shrinkWrap: true,
                children: radios!.map((e)=>ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(e.icon),
                  ),
                  title: "${e.name}".text.white.make(),
                  subtitle: e.tagline.text.white.make(),
                )
                ).toList(),
              )
            ].vStack()
            :const Offstage(),
          ),
        ),
        body: Stack(
          children: [
            Builder(
              builder: (context) {
                return VxAnimatedBox()
                    .size(context.screenWidth, context.screenHeight)
                    .withGradient(LinearGradient(
                      
                      colors: [
                        AIColors.primaryColor1,
                        
                        _selectedColor??  AIColors.primaryColor2,
                        
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ))
                    .make();
              }
            ),
                
            [AppBar(
              title: "AI Radio".text.xl4.bold.white.make().shimmer(
                  primaryColor: Vx.purple300, secondaryColor: Colors.white),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ).h(100.0).p16(),
            20.heightBox,
            "Start with - Hey Alan".text.italic.semiBold.white.make(),
            10.heightBox,
            VxSwiper.builder(itemCount: sugg.length, height: 50.0,
            viewportFraction: 0.35,
            autoPlay: true,
            autoPlayAnimationDuration: 3.seconds,
            autoPlayCurve: Curves.linear,
            enableInfiniteScroll: true,
            itemBuilder: (context,index) {
              final s= sugg[index];
              return Chip(label: s.text.make(),
              backgroundColor: Vx.randomColor,
              );
            })

            ].vStack(),
            20.heightBox,
            VxSwiper.builder(
                itemCount: (radios != null) ? radios!.length : 0,
                aspectRatio: 1.0,
                enlargeCenterPage: true,
                onPageChanged: (index){
                _selectedRadio=radios![index];
                  final colorHex=radios![index].color;
                  _selectedColor=Color(int.tryParse(colorHex)!);
                  setState(() {});
                },
                itemBuilder: (context, index) {
                  final rad = radios![index];

                  return VxBox(
                          child: ZStack(
                    [
                      Positioned(
                        child: VxBox(
                                child: rad.category.text.bold.uppercase.white
                                    .make()
                                    .px16())
                            .height(40)
                            .black
                            .alignCenter
                            .withRounded(value: 10.0)
                            .make(),
                        top: 0.0,
                        right: 0.0,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: VStack(
                          [
                            rad.name.text.white.bold.make(),
                            5.heightBox,
                            rad.tagline.text.sm.white.semiBold.make(),
                          ],
                          crossAlignment: CrossAxisAlignment.center,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: [
                          Icon(
                            CupertinoIcons.play_circle,
                            color: Colors.white,
                            size: 51.0,
                          ),
                          10.heightBox,
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
                              Colors.black.withOpacity(0.3), BlendMode.darken),
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
              padding: EdgeInsets.only(top: 620.0),
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
                      _playMusic(_selectedRadio.url);
                    }
                  }),
                  if (_isPlaying) "Tap To Stop".text.white.makeCentered(),
                  if (!_isPlaying)
                    "Double Tap To Play".text.white.makeCentered(),
                ].vStack(),
              ),
            )
          ],
          fit: StackFit.expand,
        ));
  }
}
