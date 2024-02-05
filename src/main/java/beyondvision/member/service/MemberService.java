package beyondvision.member.service;

import beyondvision.global.exeption.BadRequestException;
import beyondvision.member.domain.Member;
import beyondvision.member.domain.repository.MemberRepository;
import beyondvision.member.dto.request.UpdateMemberProfileRequest;
import beyondvision.member.dto.response.MemberProfileResponse;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import static beyondvision.global.exeption.ExceptionCode.INVALID_MEMBER;

@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberRepository memberRepository;

    @Transactional
    public MemberProfileResponse getMemberProfile(String socialId) {
        final Member member =  memberRepository.findMemberBySocialId(socialId)
                .orElseThrow(() -> new BadRequestException(INVALID_MEMBER));
        return MemberProfileResponse.of(member);
    }

    @Transactional
    public MemberProfileResponse updateMemberProfile(final Long memberId, final UpdateMemberProfileRequest profileRequest) {
        final Member member = memberRepository.findMemberById(memberId)
                .orElseThrow(() -> new BadRequestException(INVALID_MEMBER));

        member.updateMember(
                profileRequest.getName(),
                profileRequest.getAge(),
                profileRequest.getGender(),
                profileRequest.getExerciseGoal()
        );

        memberRepository.save(member);

        return MemberProfileResponse.of(member);
    }
}
