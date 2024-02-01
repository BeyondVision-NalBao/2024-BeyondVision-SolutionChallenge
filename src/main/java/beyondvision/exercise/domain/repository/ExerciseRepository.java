package beyondvision.exercise.domain.repository;

import beyondvision.exercise.domain.Exercise;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ExerciseRepository extends JpaRepository<Exercise, Long> {
}
