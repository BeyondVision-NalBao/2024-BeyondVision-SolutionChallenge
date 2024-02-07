package beyondvision.routine.domain.repository;

import beyondvision.member.domain.Member;
import beyondvision.routine.domain.Routine;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RoutineRepository extends JpaRepository<Routine, Long> {

    void deleteAllByMember(Member member);
}
