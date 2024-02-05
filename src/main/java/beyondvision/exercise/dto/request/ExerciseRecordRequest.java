package beyondvision.exercise.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ExerciseRecordRequest {

    private Integer exerciseTime;
    private Integer exerciseCount;
    private Long routineId;

    @NotNull(message = "운동 id는 필수입니다.")
    private Long exerciseId;
}
