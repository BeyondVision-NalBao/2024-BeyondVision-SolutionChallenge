package beyondvision.detail.dto;

import beyondvision.detail.domain.RoutineDetail;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;


@Getter
@AllArgsConstructor
@NoArgsConstructor
public class RoutineDetailRequest {

    private String exerciseName;
    private Integer exerciseCount;
    private Integer exerciseOrder;

}