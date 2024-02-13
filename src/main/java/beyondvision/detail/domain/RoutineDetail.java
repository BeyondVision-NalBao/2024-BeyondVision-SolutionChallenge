package beyondvision.detail.domain;

import beyondvision.exercise.domain.Exercise;
import beyondvision.member.domain.Member;
import beyondvision.routine.domain.Routine;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.DynamicInsert;

import java.util.List;
import java.util.Locale;

import static jakarta.persistence.FetchType.LAZY;
import static jakarta.persistence.GenerationType.IDENTITY;
import static lombok.AccessLevel.PROTECTED;

@Entity
@Getter
@Setter
@DynamicInsert
@AllArgsConstructor
@NoArgsConstructor(access = PROTECTED)
public class RoutineDetail {

    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;

    private String exerciseName;

    private Integer exerciseCount;

    private Integer exerciseOrder;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "routine_id", nullable = false)
    private Routine routine;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "exercise_id", nullable = false)
    private Exercise exercise;

    public void setRoutine(Routine routine) {
        this.routine = routine;
    }

    @Builder
    public RoutineDetail(
            final String exerciseName,
            final int exerciseCount,
            final int exerciseOrder,
            final Routine routine,
            final Exercise exercise
    ) {
        this.exerciseName = exerciseName;
        this.exerciseCount = exerciseCount;
        this.exerciseOrder = exerciseOrder;
        this.routine = routine;
        this.exercise = exercise;
    }

    public static RoutineDetail update(RoutineDetail routineDetail, String exerciseName, int exerciseCount, int exerciseOrder){
        routineDetail.exerciseName = exerciseName;
        routineDetail.exerciseCount = exerciseCount;
        routineDetail.exerciseOrder = exerciseOrder;
        return routineDetail;
    }

}
