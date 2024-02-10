package beyondvision.routine.service;

import beyondvision.detail.domain.RoutineDetail;
import beyondvision.detail.domain.repository.RoutineDetailRepository;
import beyondvision.detail.dto.RoutineDetailRequest;
import beyondvision.exercise.domain.repository.ExerciseRepository;
import beyondvision.global.exeption.BadRequestException;
import beyondvision.member.domain.Member;
import beyondvision.exercise.domain.Exercise;
import beyondvision.member.domain.repository.MemberRepository;
import beyondvision.routine.domain.Routine;
import beyondvision.routine.domain.repository.RoutineRepository;
import beyondvision.routine.dto.request.RoutineRequest;
import beyondvision.routine.dto.response.RoutineResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

import static beyondvision.global.exeption.ExceptionCode.INVALID_MEMBER;

@Service
@RequiredArgsConstructor
public class RoutineService {

    final MemberRepository memberRepository;
    final RoutineRepository routineRepository;
    final ExerciseRepository exerciseRepository;
    final RoutineDetailRepository routineDetailRepository;

    @Transactional
    public RoutineResponse postRoutine(final Long memberId, final RoutineRequest routinePostRequest) {
        Member member = checkExistMember(memberId);

        Routine routine = Routine.builder()
                .name(routinePostRequest.getRoutineName())
                .member(member)
                .build();

        Routine finalRoutine = routine;
        List<RoutineDetail> routineDetails = routinePostRequest.getRoutineDetails().stream()
                .map(detail -> RoutineDetail.builder()
                        .routine(finalRoutine) // Routine 객체 전달
                        .exercise(exerciseRepository.findByName(detail.getExerciseName()))
                        .exerciseName(detail.getExerciseName())
                        .exerciseCount(detail.getExerciseCount())
                        .exerciseOrder(detail.getExerciseOrder())
                        .build())
                .collect(Collectors.toList());

        routine.setRoutineDetails(routineDetails);

        routineRepository.save(routine);

        return RoutineResponse.of(routine);
    }


    @Transactional
    public List<RoutineResponse> getRoutine(final Long memberId) {
        List<Routine> routines = routineRepository.findRoutinesByMemberId(memberId);
        return routines.stream()
                .map(RoutineResponse::of)
                .toList();
    }

    @Transactional
    public RoutineResponse putRoutine(final Long memberId, final Long routineId, RoutineRequest routinePutRequest) {
        Routine updatedRoutine = routineRepository.findByMemberIdAndId(memberId, routineId);

        routineDetailRepository.deleteByRoutineId(routineId);
        Routine finalRoutine = updatedRoutine;
        List<RoutineDetail> routineDetails = routinePutRequest.getRoutineDetails().stream()
                .map(detail -> RoutineDetail.builder()
                        .routine(finalRoutine) // Routine 객체 전달
                        .exercise(exerciseRepository.findByName(detail.getExerciseName()))
                        .exerciseName(detail.getExerciseName())
                        .exerciseCount(detail.getExerciseCount())
                        .exerciseOrder(detail.getExerciseOrder())
                        .build())
                .collect(Collectors.toList());

        updatedRoutine.update(routinePutRequest.getRoutineName(),routineDetails);

/*        List<RoutineDetail> routineDetails = routinePutRequest.getRoutineDetails().stream()
                .map(detail -> RoutineDetail.update(
                        routineDetailRepository.findByRoutineId(routineId),
                        detail.getExerciseName(),
                        detail.getExerciseCount(),
                        detail.getExerciseOrder()))
                .collect(Collectors.toList());

        updatedRoutine.update(routinePutRequest.getRoutineName(), routineDetails);*/


        return RoutineResponse.of(updatedRoutine);
    }


    @Transactional
    public void deleteRoutine(final Long memberId, final Long routineId){
        Routine deletedroutine = routineRepository.findByMemberIdAndId(memberId, routineId);
        routineRepository.delete(deletedroutine);
    }

    private Member checkExistMember(final Long memberId) {
        return memberRepository.findMemberById(memberId)
                .orElseThrow(() -> new BadRequestException(INVALID_MEMBER));
    }


}
