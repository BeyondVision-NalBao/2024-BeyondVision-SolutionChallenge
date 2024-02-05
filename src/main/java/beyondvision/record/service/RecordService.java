package beyondvision.record.service;

import beyondvision.exercise.domain.Exercise;
import beyondvision.exercise.domain.repository.ExerciseRepository;
import beyondvision.exercise.dto.request.ExerciseRecordRequest;
import beyondvision.exercise.dto.response.ExerciseRecordResponse;
import beyondvision.global.exeption.BadRequestException;
import beyondvision.member.domain.Member;
import beyondvision.member.domain.repository.MemberRepository;
import beyondvision.record.domain.Record;
import beyondvision.record.domain.repository.RecordRepository;
import beyondvision.routine.domain.Routine;
import beyondvision.routine.domain.repository.RoutineRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import static beyondvision.global.exeption.ExceptionCode.INVALID_EXERCISE;
import static beyondvision.global.exeption.ExceptionCode.INVALID_MEMBER;

@Service
@RequiredArgsConstructor
public class RecordService {

    private final MemberRepository memberRepository;
    private final ExerciseRepository exerciseRepository;
    private final RoutineRepository routineRepository;
    private final RecordRepository recordRepository;

    @Transactional
    public ExerciseRecordResponse saveExerciseRecord(final Long memberId, final ExerciseRecordRequest exerciseRecordRequest) {
        Member member = memberRepository.findMemberById(memberId)
                .orElseThrow(() -> new BadRequestException(INVALID_MEMBER));

        Exercise exercise = exerciseRepository.findExerciseById(exerciseRecordRequest.getExerciseId())
                .orElseThrow(() -> new BadRequestException(INVALID_EXERCISE));

        Routine routine = routineRepository.findRoutineById(exerciseRecordRequest.getRoutineId()).orElse(null);

        Integer caloriesBurnedSum = exerciseRecordRequest.getExerciseTime() * exercise.getCaloriesBurned();

        Record record = Record.builder()
                .exerciseTime(exerciseRecordRequest.getExerciseTime())
                .caloriesBurnedSum(caloriesBurnedSum)
                .exerciseCount(exerciseRecordRequest.getExerciseCount())
                .member(member)
                .routine(routine)
                .exercise(exercise)
                .build();

        recordRepository.save(record);

        return ExerciseRecordResponse.of(record.getId(), caloriesBurnedSum);
    }
}
