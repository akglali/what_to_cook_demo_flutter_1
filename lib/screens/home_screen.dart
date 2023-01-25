import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:what_to_cook_demo_flutter_1/screens/sign_up_options.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  late VideoPlayerController _videoPlayerController;

  final positionedKey = GlobalKey();

  double boxWidth = 300;
  double boxHeight = 300;

  void _getWidgetInfo(_) {
    final RenderBox renderBox =
        positionedKey.currentContext?.findRenderObject() as RenderBox;
    positionedKey.currentContext?.size;

    final Size size = renderBox.size;
    print('Size: ${size.width}, ${size.height}');
    boxWidth = size.width;
    boxHeight = size.height;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController =
    VideoPlayerController.asset("assets/videos/back.mp4")
      ..initialize().then((_) {
        _videoPlayerController.play();
        _videoPlayerController.setVolume(0.0);
        _videoPlayerController.setLooping(true);
      });
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    SchedulerBinding.instance.addPostFrameCallback(_getWidgetInfo);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    print('Size: $boxHeight, $boxWidth');

    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.fill,
                child: SizedBox(
                  width: _videoPlayerController.value.size.width,
                  height: _videoPlayerController.value.size.height,
                  child: VideoPlayer(_videoPlayerController),
                ),
              ),
            ),
            Positioned(
              bottom: boxHeight + (boxHeight * 0.30),
              left: screenWidth / 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "WTC",
                    style: theme.textTheme.titleLarge,
                  ),
                  Text(
                    "What To Cook \n Today ?",
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            Positioned(
              //that is bottom which has the back ground
              key: positionedKey,
              bottom: 0,
              top: screenHeight / 1.3,
              child: SizedBox(
                width: screenWidth,
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // That has post pictures. Left bottom corner
              bottom: screenHeight / 20,
              right: screenWidth / 1.9,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight / 5,
                      width: screenWidth / 2.2,
                      child: Stack(
                        children: [
                          Positioned(
                            top: screenHeight / 25,
                            bottom: screenHeight / 25,
                            left: screenWidth / 50,
                            right: screenWidth / 4.9,
                            //Todo: When A post widget created instead of container will use some example of post
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green[300],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Green',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ),
                          Positioned(
                            top: screenHeight / 25,
                            bottom: screenHeight / 25,
                            left: screenWidth / 4.9,
                            right: screenWidth / 50,
                            //Todo: When A post widget created instead of container will use some example of post
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[300],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Green',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ),
                          Positioned(
                            top: screenHeight / 30,
                            bottom: screenHeight / 30,
                            left: screenWidth / 8,
                            right: screenWidth / 8,
                            //Todo: When A post widget created instead of container will use some example of post
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: Colors.red[300],
                              ),
                              child: Text(
                                'Red',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: screenWidth / 2.2,
                      height: screenHeight / 22,
                      decoration: BoxDecoration(
                        // i used textTheme color as container color onl
                        color: theme.colorScheme.onPrimaryContainer,
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Hello",
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              //that position has one of the best chef pictures. (right bottom Corner)
              bottom: screenHeight / 20,
              left: screenWidth / 1.9,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight / 5,
                      width: screenWidth / 2.2,
                      child: Stack(
                        children: [
                          Positioned(
                            top: screenHeight / 50,
                            bottom: screenHeight / 50,
                            left: screenWidth / 15,
                            right: screenWidth / 15,
                            //Todo:Best Chef photo will be added
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: Colors.red[300],
                              ),
                              child: Text(
                                'Red',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: screenWidth / 2.2,
                      height: screenHeight / 22,
                      decoration: BoxDecoration(
                        // i used textTheme color as container color onl
                        color: theme.colorScheme.onPrimaryContainer,
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Hello",
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              // that position has sign up and sign In
              bottom: screenHeight / 120,
              left: screenWidth / 27,
              right: screenWidth / 27,
              child: SizedBox(
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //TODO:I need too add show model bottom view for each
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          //container color will be visible
                          backgroundColor: Colors.transparent,
                          context: context,
                          isScrollControlled: true,
                          enableDrag: false,
                          builder: (context) => SignUpOption(),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    Text(
                      "Sign In",
                      style: theme.textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
* Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: theme
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormFieldWidget(
                        usernameController: usernameController,
                        label: "Username or Email",
                      ),
                      TextFormFieldWidget(
                        usernameController: usernameController,
                        label: "Password",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Login"),
                          style: theme.elevatedButtonTheme.style,
                        ),
                      ),
                    ],
                  ),
                ),
                * */
