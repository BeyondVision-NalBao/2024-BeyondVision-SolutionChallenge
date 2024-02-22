package beyondvision.routine.domain;

import beyondvision.detail.domain.RoutineDetail;
import beyondvision.detail.dto.RoutineDetailRequest;
import beyondvision.global.BaseEntity;
import beyondvision.member.domain.Member;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.DynamicInsert;

import java.util.ArrayList;
import java.util.List;

import static jakarta.persistence.FetchType.LAZY;
import static jakarta.persistence.GenerationType.IDENTITY;
import static lombok.AccessLevel.PROTECTED;

@Entity
@Getter
@Setter
@DynamicInsert
@AllArgsConstructor
@NoArgsConstructor(access = PROTECTED)
public class Routine extends BaseEntity {

    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;

    private String name;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "member_id", nullable = false)
    private Member member;

    @OneToMany(mappedBy = "routine", cascade = CascadeType.ALL)
    private List<RoutineDetail> routineDetails = new ArrayList<>();

    @Builder(toBuilder = true)
    public Routine(
            final String name,
            final Member member,
            final List<RoutineDetail> routineDetails
    ) {
        this.name = name;
        this.member = member;
        this.routineDetails = (routineDetails != null) ? new ArrayList<>(routineDetails) : new ArrayList<>();
    }

    public void setRoutineDetails(List<RoutineDetail> routineDetails) {
        this.routineDetails.clear();
        if (routineDetails != null) {
            this.routineDetails.addAll(routineDetails);
        }
        this.routineDetails.forEach(detail -> detail.setRoutine(this));
    }

    public void update(String name, List<RoutineDetail> routineDetails){
        this.name = name;
        this.routineDetails = routineDetails;
    }
}
