package beyondvision.record;

import beyondvision.exercise.domain.Exercise;
import beyondvision.exercise.domain.repository.ExerciseRepository;
import beyondvision.member.domain.Member;
import beyondvision.member.domain.repository.MemberRepository;
import beyondvision.record.domain.Record;
import beyondvision.record.domain.repository.RecordRepository;
import beyondvision.record.dto.request.ExerciseRecordRequest;
import beyondvision.record.dto.response.ExerciseRecordResponse;
import beyondvision.record.service.RecordService;
import beyondvision.routine.domain.Routine;
import beyondvision.routine.domain.repository.RoutineRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.transaction.annotation.Transactional;

import static beyondvision.exercise.fixture.ExerciseFixture.EXERCISE_1;
import static beyondvision.member.fixture.MemberFixture.MEMBER_1;
import static beyondvision.routine.fixture.RoutineFixture.ROUTINE_1;
import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.BDDMockito.given;

@ExtendWith(MockitoExtension.class)
@Transactional
class RecordServiceTest {

    @InjectMocks
    private RecordService recordService;

    @Mock
    private ExerciseRepository exerciseRepository;

    @Mock
    private RoutineRepository routineRepository;

    @Mock
    private RecordRepository recordRepository;

    @Mock
    private MemberRepository memberRepository;

    @DisplayName("새로운 기록을 추가한다.")
    @Test
    void save() {
        // given
        final ExerciseRecordRequest exerciseRecordRequest = new ExerciseRecordRequest(10, null, ROUTINE_1.getId(), MEMBER_1.getId());
        final Record record = new Record(60, 10, 20, 10, MEMBER_1, ROUTINE_1, EXERCISE_1);

        given(memberRepository.save(any(Member.class))).willReturn(MEMBER_1);
        given(exerciseRepository.save(any(Exercise.class))).willReturn(EXERCISE_1);
        given(routineRepository.save(any(Routine.class))).willReturn(ROUTINE_1);

        // when
        final ExerciseRecordResponse actualResponse = recordService.saveExerciseRecord(EXERCISE_1.getId(), exerciseRecordRequest);

        // then
        assertThat(actualResponse.getRecordId()).isEqualTo(record.getId());
    }
}
