import 'package:flutter/material.dart';
import 'package:lab4/CourtCounter/court_counter_team_data_container.dart';

class CourtCounterMainScreen extends StatefulWidget {
  const CourtCounterMainScreen({super.key});

  @override
  State<CourtCounterMainScreen> createState() => _CourtCounterMainScreenState();
}

class _CourtCounterMainScreenState extends State<CourtCounterMainScreen> {
  //Two Counter One For Team A and One For Team B

  int teamAC = 0;
  int teamBC = 0;

  // For incrementing the counter based on the team selected

  void incCtr({required int incFactor, required String teamName}) {
    setState(() {
      if (teamName == "Team A") {
        teamAC += incFactor;
      } else {
        teamBC += incFactor;
      }
    });
  }

// For resetting the counter
  void resetCtr() {
    setState(() {
      teamAC = teamBC = 0;
    });
  }

  // Lets build the reset buttton

  Widget resetButton() {
    return ElevatedButton(
      onPressed: resetCtr,
      child: Text("Reset"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CourtCounterTeamDataContainer(
              teamName: "Team A",
              ctrVal: teamAC,
              incCtr: incCtr,
            ),
            const SizedBox(
                height: 350,
                child: VerticalDivider(
                  width: 0,
                  thickness: 2,
                  color: Colors.black,
                )),
            CourtCounterTeamDataContainer(
              teamName: "Team B",
              ctrVal: teamBC,
              incCtr: incCtr,
            ),
          ],
        ),
        resetButton(),
      ],
    );
  }
}
