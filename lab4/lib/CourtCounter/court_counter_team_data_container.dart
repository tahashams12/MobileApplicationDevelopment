import 'package:flutter/material.dart';

class CourtCounterTeamDataContainer extends StatelessWidget {
  // Two parametres for different type of teams team A and team B
  final String teamName;
  final int ctrVal;
  final void Function({required int incFactor, required String teamName})
      incCtr;

  const CourtCounterTeamDataContainer(
      {super.key,
      required this.teamName,
      required this.ctrVal,
      required this.incCtr});

  // Lets build the container function which will hold the buttons and counter value

  Widget teamDataContainer() {
    return Column(
      children: [
        Text(teamName),
        SizedBox(
          height: 10,
        ),
        Text(
          ctrVal.toString(),
          style: TextStyle(fontSize: 50),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: buildIncButton(incFactor: 3, buttonText: "+3 POINTS"),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: buildIncButton(incFactor: 2, buttonText: "+2 POINTS"),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: buildIncButton(incFactor: 1, buttonText: "FREE THROW "),
        ),
      ],
    );
  }

  Widget buildIncButton({required int incFactor, required String buttonText}) {
    return SizedBox(
      width: 140,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          incCtr(incFactor: incFactor, teamName: teamName);
        },
        child: Text(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return teamDataContainer();
  }
}
