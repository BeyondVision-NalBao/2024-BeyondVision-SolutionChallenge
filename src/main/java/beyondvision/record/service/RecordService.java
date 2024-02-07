package beyondvision.record.service;

import beyondvision.exercise.domain.Exercise;
import beyondvision.exercise.domain.repository.ExerciseRepository;
import beyondvision.global.exeption.BadRequestException;
import beyondvision.member.domain.Member;
import beyondvision.member.domain.repository.MemberRepository;
import beyondvision.record.domain.Record;
import beyondvision.record.domain.repository.RecordRepository;
import beyondvision.record.dto.request.ExerciseRecordRequest;
import beyondvision.record.dto.response.ExerciseRecordResponse;
import beyondvision.routine.domain.repository.RoutineRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static beyondvision.global.exeption.ExceptionCode.INVALID_EXERCISE;
import static beyondvision.global.exeption.ExceptionCode.INVALID_MEMBER;

@Service
@RequiredArgsConstructor
public class RecordService {

    private final MemberRepository memberRepository;
    private final ExerciseRepository exerciseRepository;
    private final RecordRepository recordRepository;

    @Transactional(readOnly = true)
    public List<ExerciseRecordResponse> getExerciseRecord(final Long memberId) {
        Member member = checkExistMember(memberId);
        List<Record> records = recordRepository.getRecordByMemberIdBetween(member.getId());
        return records.stream()
                .map(ExerciseRecordResponse::of)
                .toList();
    }

    @Transactional
    public ExerciseRecordResponse saveExerciseRecord(final Long exerciseId, final ExerciseRecordRequest exerciseRecordRequest) {
        Member member = checkExistMember(exerciseRecordRequest.getMemberId());

        Exercise exercise = exerciseRepository.findExerciseById(exerciseId)
                .orElseThrow(() -> new BadRequestException(INVALID_EXERCISE));

        Record record = Record.builder()
                .exerciseTime(exerciseRecordRequest.getExerciseTime())
                .exerciseCount(exerciseRecordRequest.getExerciseCount())
                .member(member)
                .exercise(exercise)
                .build();

        recordRepository.save(record);

        return ExerciseRecordResponse.of(record);
    }

    private Member checkExistMember(final Long memberId) {
        return memberRepository.findMemberById(memberId)
                .orElseThrow(() -> new BadRequestException(INVALID_MEMBER));
    }
}
