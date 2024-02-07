package beyondvision.record.domain;

import beyondvision.exercise.domain.Exercise;
import beyondvision.global.BaseEntity;
import beyondvision.member.domain.Member;
import beyondvision.routine.domain.Routine;
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
public class Record extends BaseEntity {

    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long exerciseTime;

    private Integer caloriesBurnedSum;

    private Integer averageHeartRate;

    private Integer exerciseCount;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "member_id", nullable = false)
    private Member member;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "exercise_id", nullable = false)
    private Exercise exercise;
}
