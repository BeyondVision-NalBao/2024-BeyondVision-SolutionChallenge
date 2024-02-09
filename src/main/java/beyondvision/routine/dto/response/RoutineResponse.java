package beyondvision.routine.dto.response;

import beyondvision.detail.domain.RoutineDetail;
import beyondvision.routine.domain.Routine;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.List;

import static lombok.AccessLevel.PRIVATE;

@Getter
@RequiredArgsConstructor(access=PRIVATE)
public class RoutineResponse {
    private final Long routineId;
    private final String routineName;
    private final List<RoutineDetail> routineDetails;

    public static RoutineResponse of (final Routine routine){
        return new RoutineResponse(
                routine.getId(),
                routine.getName(),
                routine.getRoutineDetails());
    }
}
