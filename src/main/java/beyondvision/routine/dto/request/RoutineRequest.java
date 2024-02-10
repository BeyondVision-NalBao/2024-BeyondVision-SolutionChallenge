package beyondvision.routine.dto.request;

import beyondvision.detail.domain.RoutineDetail;
import beyondvision.detail.dto.RoutineDetailRequest;
import beyondvision.exercise.domain.Exercise;
import beyondvision.exercise.domain.repository.ExerciseRepository;
import beyondvision.routine.domain.Routine;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.stream.Collectors;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class RoutineRequest {

    private String routineName;
    private List<RoutineDetailRequest> routineDetails;


}
