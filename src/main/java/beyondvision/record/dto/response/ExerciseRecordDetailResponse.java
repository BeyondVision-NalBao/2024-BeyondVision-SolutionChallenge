package beyondvision.record.dto.response;

import beyondvision.record.domain.Record;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

import static lombok.AccessLevel.PRIVATE;

@Getter
@RequiredArgsConstructor(access = PRIVATE)
public class ExerciseRecordDetailResponse {

    private final Long recordId;
    private final Integer caloriesBurnedSum;
    private final Integer exerciseCount;
    private final Integer exerciseTime;
    private final String exerciseName;

    public static ExerciseRecordDetailResponse of(final Record record) {
        return new ExerciseRecordDetailResponse(
                record.getId(),
                record.getCaloriesBurnedSum(),
                record.getExerciseCount(),
                record.getExerciseTime(),
                record.getExercise().getName());
    }
}