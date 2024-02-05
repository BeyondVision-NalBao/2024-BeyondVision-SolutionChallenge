package beyondvision.exercise.fixture;

import beyondvision.exercise.domain.Exercise;

import java.util.List;

public class ExerciseFixture {

    // 상체: 0, 하체: 1, 코어: 2, 스트레칭: 3
    public static final List<Exercise> EXERCISES = List.of(
            new Exercise("레터럴 레이즈", "설명 1", 30, 5, 0),
            new Exercise("숄더 프레스", "설명 2", 20, 4, 0),
            new Exercise("트라이셉 익스텐션", "설명 3", 10, 4, 0),
            new Exercise("스쿼트", "설명 4", 10, 20, 1),
            new Exercise("런지", "설명 5", 10, 20, 1),
            new Exercise("닐링 레그 리프트", "설명 6", 10, 20, 1),
            new Exercise("플랭크", "설명 7", 10, 4, 2),
            new Exercise("헌드레드", "설명 8", 10, 4, 2),
            new Exercise("브릿지", "설명 9", 10, 4, 2)
    );
}
