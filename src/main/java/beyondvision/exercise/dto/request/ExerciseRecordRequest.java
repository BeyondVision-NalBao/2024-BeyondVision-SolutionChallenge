package beyondvision.exercise.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class ExerciseRecordRequest {

    private final Integer exerciseTime;
    private final Integer exerciseCount;
    private final Long routineId;

    @NotNull(message = "운동 id는 필수입니다.")
    private final Long exerciseId;
}
