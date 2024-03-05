import 'package:beyond_vision/model/routine_model.dart';
import 'package:beyond_vision/model/workout_model.dart';
import 'package:beyond_vision/model/record_model.dart';
import 'package:intl/intl.dart';

class TtsService {
  final String wrongNotice = "이동과 설명 중 하나를 말씀해주세요";
  final String InitExplain = "안녕하세요 비욘드비전입니다. 구글 로그인 하시면 서비스를 이용하실수 있습니다.";
  final String newInfoExplain = "추가 정보를 입력해주세요. 성별, 나이, 운동 목표를 작성해주세요";

  String getMainExplain() {
    return "비욘드비전은 혼자서도 효과적으로 운동할 수 있도록 도와주는 어플입니다. 카메라로 촬영한 운동 영상을 실시간으로 분석하고 여러분이 더 정확한 자세를 잡을 수 있도록 필요한 피드백을 제공합니다. 또한 자기만의 운동 루틴을 자유롭게 설정해둘 수 있고, 비욘드비전과 함께 운동한 기록도 언제 어디서든 확인할 수 있습니다. 그럼 이제 같이 운동하러 가보실까요?";
  }

  String getWorkout() {
    return "이 페이지에서는 어떤 운동을 할지 선택할 수 있습니다. 비욘드비전은 상체, 하체, 코어운동과 스트레칭 가이드를 제공합니다. 뿐만아니라 추천 운동을 할 수도 있고, 저장해둔 루틴대로 운동할 수도 있습니다.";
  }

  String getWorkoutDetail(List<WorkOut> workouts, String cate) {
    //카테고리 별 운동 이름 필요
    String workoutString = "";
    for (int i = 0; i < workouts.length; i++) {
      workoutString += "${workouts[i].name} ";
    }
    return "이 $cate 카테고리에는 $workoutString 운동이 있습니다. 각 운동을 누르면 운동 설명을 확인하고 운동을 시작할 수 있습니다.";
  }

  String getRoutineExplain(List<Routine> routines) {
    String routinesName = "";
    //루틴 이름 필요
    for (int i = 0; i < routines.length; i++) {
      routinesName += "${i + 1}번 ${routines[i].routineName}";
    }
    return "이 페이지에서는 나만의 운동 루틴을 생성하고 수정할 수 있습니다. 플러스 버튼을 눌러 루틴을 생성할 수 있습니다.\n현재 루틴이 ${routines.length}개 있습니다. $routinesName 이 있습니다다.각 루틴 버튼을 약 2초간 누르면 루틴 이름을 수정하거나 루틴을 삭제할 수 있습니다. ";
  }

  String getRoutineDetailExplain(Routine routine) {
    String routineString = "";
    for (int i = 0; i < routine.routineDetails.length; i++) {
      routineString +=
          "${routine.routineDetails[i].exerciseName}를 ${routine.routineDetails[i].exerciseCount}회, ";
    }
    //루틴 이름, 루틴 내의 운동 이름, count 필요
    return "이 페이지에서는 각 루틴에 운동을 추가하거나, 순서를 수정할 수 있습니다. ${routine.routineName} 은 차례대로 $routineString 수행합니다.화면의 아래 플러스 버튼을 눌러 운동을 추가할 수 있습니다.또한 각 운동 박스의 오른쪽의 위아래 방향 아이콘을 누른 상태에서 박스들의 순서를 변경할 수 있습니다. 순서 변경 후에는 화면 아래의 체크표시를 눌러 주는 것도 잊지 마세요";
  }

  String getDailyRecord(List<Record> records, double time, DateTime date) {
    //이번주 record 기록 필요
    //daily인지 뭔지 확인
    String formatDate = DateFormat('yy-mm-dd').format(date);
    if (records.isEmpty &&
        formatDate == DateFormat('yy-mm-dd').format(DateTime.now())) {
      return "이 페이지에서는 과거의 운동 기록을 확인할 수 있습니다. 오늘은 아직 운동을 하지 않으셨군요! 오늘도 BV와 함꼐 운동하러 가요";
    } else if (records.isNotEmpty &&
        formatDate == DateFormat('yy-mm-dd').format(DateTime.now())) {
      String results = "";
      for (int i = 0; i < records.length; i++) {
        results += "${records[i].exerciseName}를 ${records[i].exerciseTime}초, ";
      }
      int times = time.toInt();

      return "오늘은 총 $times분의 운동을 하셨습니다. $results를 진행하셨네요. 수고하셨습니다";
    } else if (formatDate != DateFormat('yy-mm-dd').format(DateTime.now()) &&
        records.isNotEmpty) {
      String workoutDay = "${date.month.toString}월 ${date.day.toString}일";
      String results = "";
      for (int i = 0; i < records.length; i++) {
        results += "${records[i].exerciseName}를 ${records[i].exerciseTime}초, ";
      }
      String times = time.toInt().toString();
      return "$workoutDay에는 총 $times분의 운동을 하셨습니다. $results를 진행하셨네요. 수고하셨습니다";
    } else {
      String month = date.month.toString();
      String day = date.day.toString();
      String workoutDay = "$month월 $day일에는 운동을 하지 않으셨네요. 오늘은 BV와 함께 운동하실거죠?";

      return workoutDay;
    }
  }

  String getWeeklyRecord(List<List<Record>> records, List<double> time) {
    String successDays = "";
    String days = "";
    List<String> weekdays = ["월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"];
    for (int i = 0; i < records.length; i++) {
      if ((time[i] / 60) > 0) {
        successDays += "${weekdays[records[i][0].exerciseDate!.weekday - 1]}, ";
      }
      days += "${weekdays[records[i][0].exerciseDate!.weekday - 1]}, ";
    }
    if (records.isEmpty) {
      return "이 주에는 운동을 한 번도 하지 않으셨네요. 지금 BV와 함께 운동하러 가요!";
    } else {
      int recordLength = records.length;
      return "이 주에는 $days, 총 $recordLength번 운동하셨네요. $successDays는 운동 목표를 달성하셨네요. 다음 주도 화이팅입니다!";
    }
  }

  String getSetting() {
    return "이 페이지에서는 여러분들의 정보를 관리할 수 있습니다. 운동 목표를 수정할 수도 있고 로그아웃할 수도 있습니다.";
  }
}
