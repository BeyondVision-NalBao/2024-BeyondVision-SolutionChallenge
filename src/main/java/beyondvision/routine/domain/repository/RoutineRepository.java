package beyondvision.routine.domain.repository;

import beyondvision.routine.domain.Routine;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoutineRepository extends JpaRepository<Routine, Long> {
}
