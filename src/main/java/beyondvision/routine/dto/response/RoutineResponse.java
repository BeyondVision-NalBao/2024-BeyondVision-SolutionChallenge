package beyondvision.routine.dto.response;

import beyondvision.detail.domain.RoutineDetail;
import beyondvision.detail.dto.RoutineDetailResponse;
import beyondvision.routine.domain.Routine;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.stream.Collectors;

import static lombok.AccessLevel.PRIVATE;

@Getter
@RequiredArgsConstructor(access=PRIVATE)
public class RoutineResponse {
    private final Long routineId;
    private final String routineName;
    private final List<RoutineDetailResponse> routineDetails;

    public static RoutineResponse of(Routine routine) {
        List<RoutineDetailResponse> detailResponses = routine.getRoutineDetails().stream()
                .map(RoutineDetailResponse::of)
                .collect(Collectors.toList());

        return new RoutineResponse(
                routine.getId(),
                routine.getName(),
                detailResponses
        );
    }
}
