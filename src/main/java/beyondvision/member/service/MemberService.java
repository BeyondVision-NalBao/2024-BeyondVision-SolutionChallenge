package beyondvision.member.service;

import beyondvision.global.exeption.BadRequestException;
import beyondvision.member.domain.Member;
import beyondvision.member.domain.repository.MemberRepository;
import beyondvision.member.dto.request.UpdateMemberInfoRequest;
import beyondvision.member.dto.response.MemberInfoResponse;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import static beyondvision.global.exeption.ExceptionCode.INVALID_MEMBER;

@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberRepository memberRepository;

    @Transactional
    public MemberInfoResponse getMemberInfo(final Long memberId) {
        final Member member = checkExistMember(memberId);
        return MemberInfoResponse.of(member);
    }

    @Transactional
    public MemberInfoResponse updateMemberInfo(final Long memberId, final UpdateMemberInfoRequest profileRequest) {
        final Member member = checkExistMember(memberId);
        member.updateMember(profileRequest.getExerciseGoal());
        memberRepository.save(member);
        return MemberInfoResponse.of(member);
    }

    private Member checkExistMember(final Long memberId) {
        return memberRepository.findMemberById(memberId)
                .orElseThrow(() -> new BadRequestException(INVALID_MEMBER));
    }
}
