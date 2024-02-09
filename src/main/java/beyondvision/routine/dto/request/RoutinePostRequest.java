package beyondvision.routine.dto.request;

import beyondvision.detail.domain.RoutineDetail;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class RoutinePostRequest {

    private String name;
    private List<RoutineDetail> routineDetails;
}
