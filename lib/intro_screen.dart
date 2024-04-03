import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_toc_game/home.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  //@override
  // void dispose() {
  //   super.dispose();
  //   player.dispose();
  // }
  @override
  void initState() {
    super.initState();
    playMusic();
    isClicked = true;
  }
  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }
    final player = AudioPlayer();
   bool isClicked = false;
  final whiteType = GoogleFonts.pressStart2p(
      textStyle: const TextStyle(color: Colors.white, letterSpacing: 3));
  final blackType = GoogleFonts.pressStart2p(
      textStyle: const TextStyle(color: Colors.black, letterSpacing: 3));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(onPressed: (){
            setState(() {
            isClicked = !isClicked;
            if (isClicked) {
            playMusic();
          } else {
            pauseMusic();
          }
          }
          );
             
              
          },  icon: Icon(
    isClicked ? Icons.music_note : (isClicked == false ? Icons.music_off : null),
    color:  Colors.white,
  ),
          )
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  child: Text(
                    'Tic Tac Toe',
                    style: whiteType.copyWith(fontSize: 25),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 120),
                  child: AvatarGlow(
                    duration: const Duration(seconds: 2),
                    glowColor: Colors.white,
                    repeat: true,
                    startDelay: const Duration(seconds: 1),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.none,
                          ),
                          shape: BoxShape.circle),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[900],
                        radius: 80.0,
                        child: Image.network(
                          'https://github.com/mitchkoko/tictactoeflutter/blob/master/lib/images/tictactoelogo.png?raw=true',
                          color: Colors.white,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 300,
                ),
                GestureDetector(
                  onTap: () {
                    player.stop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const Home()));
                  },
                  child: Container(
                    width: 300,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: Center(
                        child: Text('Play a Game',
                            style: blackType.copyWith(fontSize: 20))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
 Future <void> playMusic()async {
  await  player.play(AssetSource('theme_01.mp3'));
  player.setReleaseMode(ReleaseMode.loop);
    
  }
  void pauseMusic(){
    player.pause();
  }
}
