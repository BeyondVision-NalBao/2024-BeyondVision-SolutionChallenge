package beyondvision.routine.domain;

import beyondvision.exercise.domain.Exercise;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicInsert;

import static jakarta.persistence.FetchType.LAZY;
import static jakarta.persistence.GenerationType.IDENTITY;
import static lombok.AccessLevel.PROTECTED;

@Entity
@Getter
@DynamicInsert
@AllArgsConstructor
@NoArgsConstructor(access = PROTECTED)
public class RoutineDetail {

    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;

    private Integer exerciseCount;

    private Integer exerciseOrder;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "routine_id", nullable = false)
    private Routine routine;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "exercise_id", nullable = false)
    private Exercise exercise;
}
