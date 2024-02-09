package beyondvision.routine.domain.repository;

import beyondvision.member.domain.Member;
import beyondvision.routine.domain.Routine;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface RoutineRepository extends JpaRepository<Routine, Long> {


    List<Routine> findRoutinesByMemberId(final Long memberId);

    Routine findByMemberIdAndId(final Long memberId, final Long routineId);

    void deleteAllByMember(Member member);
}
