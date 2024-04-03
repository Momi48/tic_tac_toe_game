import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> display = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  List<String> newDisplay = [];
  final player = AudioPlayer();
  int score0 = 0;
  int scoreX = 0;
  bool isTurn = false;
  bool isWinner = false;
  final text = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  final newtext = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red);
  final whiteType = GoogleFonts.pressStart2p(
      textStyle: const TextStyle(color: Colors.white, letterSpacing: 3));
  final blackType = GoogleFonts.pressStart2p(
      textStyle: const TextStyle(color: Colors.black, letterSpacing: 3));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Tic Toe Game', style: whiteType),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('Player X', style: whiteType),
                  Text('Score: ${scoreX.toString()}', style: whiteType),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Player 0',
                    style: whiteType,
                  ),
                  Text('Score: ${score0.toString()}', style: whiteType),
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                // assign new list//
                display = List.filled(9, '');
                isTurn = false;
                isWinner = false;
              });
            },
            child: Container(
              height: 30,
              width: 140,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Center(child: Text('Restart', style: blackType)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Visibility(
            //true display it and false hide it
            visible: isWinner == true ? false : true,
            child: Text(
              !isTurn ? 'O Turn Now' : 'X Turn Now',
              style: whiteType,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  Color textColor = Colors.white;
                //index help us identify which row or column it matches

                  // Check the first row
                  if(index < 3){
                  
                  if (display[0] == display[1] &&
                      display[0] == display[2] &&
                      display[0] != '') {
                    textColor = Colors.amberAccent;
                  }
                   }
                  //check second row
                  if(index >= 3 && index < 6){
                          if (display[3] == display[4] &&
                      display[3] == display[5] &&
                      display[3] != '') {
                    textColor = Colors.amberAccent;
                  }
                  }
                   // Check the third row
                  if(index >=6 && index <9 ){
                    if (display[6] == display[7] &&
                      display[6] == display[8] &&
                      display[6] != '') {
                    textColor = Colors.amberAccent;
                  }
                  }
                  //check first column//
                  if(index % 3 == 0){
                    if(display[0] == display[3] && display[0] == display[6]&& display[0] != ''){
                    textColor = Colors.amberAccent;

                    }
                  }
                  //check second column//
                  if(index % 3 == 1){
                    if(display[1] == display[4] && display[1] == display[7] && display[1] != ''){
                       textColor = Colors.amberAccent;
                    }
                    
                  }
                  
                   // Check the third column
                   if(index % 3 == 2){
                     if(display[2] == display[5] && display[2] == display[8] && display[2] != ''){
                      textColor = Colors.amberAccent;
                     }
                   }
                   //left diagonal
                   if(index == 0 || index == 4 ||  index == 8){
                     if(display[0] == display[4] && display[0] == display[8] && display[0] != ''){
                      textColor = Colors.amberAccent;
                     }
                   }
                   //right diagonal
                   if( index == 2 || index == 4 || index == 6){
                     if(display[2] == display[4] && display[2] == display[6] && display[2] != ''){
                      textColor = Colors.amberAccent;
                     }
                   }
                  return GestureDetector(
                    onTap: () {
                      tapped(index);
                      setState(() {
                      isTurn = !isTurn;
                      // if it becomes equal to 'O' 
                      // if it becomes equal to 'X' 
                       if(isTurn || !isTurn){
                        playSound();
                       }
                      }
                      );
                        checkWinner();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                      ),
                      child: Center(
                          child: Text(
                        display[index],
                        style: whiteType.copyWith(color: textColor),
                      )),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
 
  void tapped(int index) {
    setState(() {
      
      if (!isTurn && display[index] == '') {
        display[index] = 'O';
      } else if (isTurn && display[index] == '') {
        display[index] = 'X';
      }
    });
  }

  checkWinner() {
    //1st
    
    if (display[0] == display[1] &&
        display[0] == display[2] &&
        display[0] != '') {
      isWinner = true;
     // winningIndices=[0,1,2];
      showWinnerDialog(display[0]);
    }
    //2nd row
    else if (display[3] == display[4] &&
        display[3] == display[5] &&
        display[3] != '') {
      isWinner = true;
   //   winningIndices=[3,4,5];
      showWinnerDialog(display[3]);
    }
    //3rd row
    else if (display[6] == display[7] &&
        display[6] == display[8] &&
        display[6] != '') {
      isWinner = true;
    //  winningIndices=[6,7,8];
      showWinnerDialog(display[6]);
    }
    //1st column
    else if (display[0] == display[3] &&
        display[0] == display[6] &&
        display[0] != '') {
      isWinner = true;
     // winningIndices=[0,3,6];
      showWinnerDialog(display[0]);
    }
    //2nd column
    else if (display[1] == display[4] &&
        display[1] == display[7] &&
        display[1] != '') {
      isWinner = true;
    //  winningIndices=[1,4,7];
      showWinnerDialog(display[1]);
    }
    //3rd column
    else if (display[2] == display[5] &&
        display[2] == display[8] &&
        display[2] != '') {
      isWinner = true;
   //   winningIndices=[2,5,8];
      showWinnerDialog(display[2]);
    }
    //left diagonal//
    else if (display[0] == display[4] &&
        display[0] == display[8] &&
        display[0] != '') {
      isWinner = true;
   //   winningIndices=[0,4,8];
      showWinnerDialog(display[0]);
    }
    //right dialog//
    else if (display[2] == display[4] &&
        display[2] == display[6] &&
        display[2] != '') {
      isWinner = true;
   //   winningIndices=[2,4,6];
      showWinnerDialog(display[2]);
    }
    else if (display.every((input) => input == 'X' || input == 'O')) {
   //   winningIndices=[];
      drawMessage();
    }
   // return winningIndices;
  //  else {
  //   checkDraw();
  //  }
  }
// void reset (){
//    for(int i = 0; i<9 ;i++){
//       display[i] = '';
//    }
// }
  void showWinnerDialog(String winner) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Winner $winner'),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      //initialze new list and assign to display or reset the list
                      display = List.filled(9, '');
                      isTurn = false;
                      isWinner = false;

                      Navigator.pop(context);
                    });
                  },
                  child: const Text('Play Again')),
         
            ],
          );
        });
    if (winner == 'O') {
      score0++;
    } else if (winner == 'X') {
      scoreX++;
    }
  }
  void drawMessage(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Match is Draw '),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      //initialze new list and assign to display or reset the list
                      display = List.filled(9, '');
                      isTurn = false;
                      isWinner = false;

                      Navigator.pop(context);
                    });
                  },
                  child: const Text('Play Again')),
            
            ],
          );
        });
    
  }
  void playSound(){
     player.play(AssetSource('move-self.mp3'));
  }
}
