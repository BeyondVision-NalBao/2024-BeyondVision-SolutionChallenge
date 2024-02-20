package beyondvision.exercise.service;

import beyondvision.exercise.domain.Exercise;
import beyondvision.exercise.domain.repository.ExerciseRepository;
import beyondvision.exercise.dto.response.ExerciseDetailResponse;
import beyondvision.global.exeption.BadRequestException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Random;

import static beyondvision.global.exeption.ExceptionCode.INVALID_EXERCISE_CATEGORY;

@Service
@RequiredArgsConstructor
@Transactional
public class ExerciseService {

    private final ExerciseRepository exerciseRepository;

    @Transactional(readOnly = true)
    public List<ExerciseDetailResponse> getExerciseDetailByCategory(final Integer categoryNumber) {
        final List<Exercise> exercises = exerciseRepository.findByCategoryNumber(categoryNumber);

        if (exercises.isEmpty())
            throw new BadRequestException(INVALID_EXERCISE_CATEGORY);

        return exercises.stream()
                .map(ExerciseDetailResponse::of)
                .toList();
    }

    @Transactional
    public ExerciseDetailResponse getRandomExercise(){
        Random random = new Random();
        long randomNumber = random.nextInt(11) + 1;
        Exercise randomExercise = exerciseRepository.findExerciseById(randomNumber);
        return ExerciseDetailResponse.of(randomExercise);
    }
}
