package beyondvision.exercise.fixture;

import beyondvision.exercise.domain.Exercise;

import java.util.List;

public class ExerciseFixture {

    public static final Exercise EXERCISE_1 = new Exercise("레터럴 레이즈", "설명 1", null, 5, 0);

    // 상체: 0, 하체: 1, 코어: 2, 스트레칭: 3
    public static final List<Exercise> EXERCISES = List.of(
            new Exercise("레터럴 레이즈", "설명 1", null, 5, 0),
            new Exercise("숄더 프레스", "설명 2", null, 4, 0),
            new Exercise("프론트 레이즈", "설명 3", null, 4, 0),
            new Exercise("스쿼트", "설명 4", null, 20, 1),
            new Exercise("런지", "설명 5", null, 20, 1),
            new Exercise("닐링 레그 리프트", "설명 6", 10, 20, 1),
            new Exercise("플랭크", "설명 7", null, 4, 2),
            new Exercise("헌드레드", "설명 8", null, 4, 2),
            new Exercise("브릿지", "설명 9", null, 4, 2),
            new Exercise("V", "설명 10", null, 4, 2)
    );
}
