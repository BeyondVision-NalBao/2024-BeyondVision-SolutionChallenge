package beyondvision.detail.dto;

import beyondvision.detail.domain.RoutineDetail;
import beyondvision.routine.domain.Routine;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.List;

import static lombok.AccessLevel.PRIVATE;

@Getter
@RequiredArgsConstructor(access=PRIVATE)
public class RoutineDetailResponse {
    private final Long id;
    private final String exerciseName;
    private final Integer exerciseCount;
    private final Integer exerciseOrder;


    public static RoutineDetailResponse of(RoutineDetail routineDetail) {
        return new RoutineDetailResponse(
                routineDetail.getId(),
                routineDetail.getExerciseName(),
                routineDetail.getExerciseCount(),
                routineDetail.getExerciseOrder()
        );
    }
}
