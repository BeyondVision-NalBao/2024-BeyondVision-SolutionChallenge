package beyondvision.routine.service;

import beyondvision.detail.domain.RoutineDetail;
import beyondvision.global.exeption.BadRequestException;
import beyondvision.member.domain.Member;
import beyondvision.member.domain.repository.MemberRepository;
import beyondvision.routine.domain.Routine;
import beyondvision.routine.domain.repository.RoutineRepository;
import beyondvision.routine.dto.request.RoutinePostRequest;
import beyondvision.routine.dto.response.RoutineResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static beyondvision.global.exeption.ExceptionCode.INVALID_MEMBER;

@Service
@RequiredArgsConstructor
public class RoutineService {

    final MemberRepository memberRepository;
    final RoutineRepository routineRepository;

    @Transactional
    public RoutineResponse postRoutine(final Long memberId, final RoutinePostRequest routinePostRequest){
        Member member = checkExistMember(memberId);
        Routine routine = Routine.builder()
                .name(routinePostRequest.getName())
                .member(member)
                .routineDetails(routinePostRequest.getRoutineDetails())
                .build();
        routineRepository.save(routine);
        return RoutineResponse.of(routine);
    }

    @Transactional
    public List<RoutineResponse> getRoutine(final Long memberId) {
        Member member = checkExistMember(memberId);
        List<Routine> routines = routineRepository.findRoutinesByMemberId(memberId);
        return routines.stream()
                .map(RoutineResponse::of)
                .toList();
    }

    private Member checkExistMember(final Long memberId) {
        return memberRepository.findMemberById(memberId)
                .orElseThrow(() -> new BadRequestException(INVALID_MEMBER));
    }


}
