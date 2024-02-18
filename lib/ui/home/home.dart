import 'package:beyond_vision/provider/login_provider.dart';
import 'package:beyond_vision/ui/appbar.dart';
import 'package:beyond_vision/ui/home/widgets/home_grid_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final int? memberId;
  final int? exerciseGoal;
  const HomePage({Key? key, this.memberId, this.exerciseGoal})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // initState 메서드에서 상태를 변경하도록 함
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    if (widget.memberId != null && widget.exerciseGoal != null) {
      auth.getMemberId(widget.memberId!);
      auth.getGoal(widget.exerciseGoal!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context, titleText: " "),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: GridView.count(
              crossAxisCount: 2,
              children: const [
                HomeButton(name: "운동 하기"),
                HomeButton(name: "운동 루틴"),
                HomeButton(name: "운동 기록"),
                HomeButton(name: "앱 설정")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
