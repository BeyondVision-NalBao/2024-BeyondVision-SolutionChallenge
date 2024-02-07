package beyondvision.routine.domain;

import beyondvision.exercise.domain.Exercise;
import beyondvision.global.BaseEntity;
import beyondvision.member.domain.Member;
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
public class Routine extends BaseEntity {

    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;

    private String name;

    private Integer exerciseCount;

    private Integer exerciseOrder;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "member_id", nullable = false)
    private Member member;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "exercise_id", nullable = false)
    private Exercise exercise;

    public Routine(
            final String name,
            final Integer exerciseCount,
            final Integer exerciseOrder,
            final Member member,
            final Exercise exercise
    ) {
        this.name = name;
        this.exerciseCount = exerciseCount;
        this.exerciseOrder = exerciseOrder;
        this.member = member;
        this.exercise = exercise;
    }
}
