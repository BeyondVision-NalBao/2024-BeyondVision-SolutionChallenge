package beyondvision.exercise;

import beyondvision.exercise.domain.repository.ExerciseRepository;
import beyondvision.exercise.dto.response.ExerciseDetailResponse;
import beyondvision.exercise.service.ExerciseService;
import beyondvision.global.exeption.BadRequestException;
import jakarta.transaction.Transactional;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Collections;
import java.util.List;

import static beyondvision.exercise.fixture.ExerciseFixture.EXERCISES;
import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.BDDMockito.given;

@ExtendWith(MockitoExtension.class)
@Transactional
class ExerciseServiceTest {

    @InjectMocks
    private ExerciseService exerciseService;

    @Mock
    private ExerciseRepository exerciseRepository;

    @DisplayName("카테고리별 운동 종류 상세 조회")
    @Test
    void getExerciseDetailByCategory() {
        // given
        final List<ExerciseDetailResponse> responses = EXERCISES.stream()
                .map(ExerciseDetailResponse::of)
                .toList();

        given(exerciseRepository.findByCategoryNumber(0))
                .willReturn(EXERCISES);

        // when
        final List<ExerciseDetailResponse> actualResponses = exerciseService.getExerciseDetailByCategory(0);

        // then
        assertThat(actualResponses).usingRecursiveComparison().isEqualTo(responses);
    }

    @DisplayName("카테고리 번호에 해당하는 운동이 존재하지 않으면 예외가 발생한다.")
    @Test
    void notFoundCategory() {
        // given
        given(exerciseRepository.findByCategoryNumber(3)).willReturn(Collections.emptyList());

        // when & then
        assertThatThrownBy(() -> exerciseService.getExerciseDetailByCategory(3))
                .isInstanceOf(BadRequestException.class);
    }
}
