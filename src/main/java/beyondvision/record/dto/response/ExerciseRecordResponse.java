package beyondvision.record.dto.response;

import beyondvision.record.domain.Record;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.time.LocalDateTime;

import static lombok.AccessLevel.PRIVATE;

@Getter
@RequiredArgsConstructor(access = PRIVATE)
public class ExerciseRecordResponse {

    private final Long recordId;
    private final Integer exerciseCount;
    private final Integer exerciseTime;
    private final String exerciseName;
    private final LocalDateTime exerciseDate;

    public static ExerciseRecordResponse of(final Record record) {
        return new ExerciseRecordResponse(
                record.getId(),
                record.getExerciseCount(),
                record.getExerciseTime(),
                record.getExercise().getName(),
                record.getCreatedTime());
    }
}