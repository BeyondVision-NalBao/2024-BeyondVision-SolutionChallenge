package beyondvision.exercise.dto.response;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

import static lombok.AccessLevel.PRIVATE;

@Getter
@RequiredArgsConstructor(access = PRIVATE)
public class ExerciseRecordResponse {

    private final Long recordId;
    private final Integer caloriesBurnedSum;

    public static ExerciseRecordResponse of(final Long recordId, final Integer caloriesBurnedSum) {
        return new ExerciseRecordResponse(recordId, caloriesBurnedSum);
    }
}