package beyondvision.exercise.domain.repository;

import beyondvision.exercise.domain.Exercise;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ExerciseRepository extends JpaRepository<Exercise, Long> {

    Optional<Exercise> findExerciseById(final Long exerciseId);

    Exercise findByName(final String exerciseName);
    List<Exercise> findByCategoryNumber(final Integer CategoryNumber);
}
