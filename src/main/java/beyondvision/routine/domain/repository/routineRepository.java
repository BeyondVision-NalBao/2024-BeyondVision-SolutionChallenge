package beyondvision.routine.domain.repository;

import beyondvision.routine.domain.Routine;
import org.springframework.data.jpa.repository.JpaRepository;

public interface routineRepository extends JpaRepository<Routine, Long> {
}
