package beyondvision.auth.service;

import beyondvision.auth.dto.response.AuthResponse;
import beyondvision.global.exeption.BadRequestException;
import beyondvision.member.domain.Member;
import beyondvision.member.domain.repository.MemberRepository;
import beyondvision.member.dto.request.SignUpMemberRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import static beyondvision.global.exeption.ExceptionCode.EXIST_MEMBER;

@Service
@RequiredArgsConstructor
public class AuthService {
    private final MemberRepository memberRepository;

    public AuthResponse signUp(SignUpMemberRequest signUpMemberRequest) {

        if (memberRepository.existsBySocialId(signUpMemberRequest.getSocialId()))
            throw new BadRequestException(EXIST_MEMBER);

        Member member = memberRepository.save(Member.builder()
                .name(signUpMemberRequest.getName())
                .email(signUpMemberRequest.getEmail())
                .socialId(signUpMemberRequest.getSocialId())
                .profileImageUrl(signUpMemberRequest.getProfileImageUrl())
                .age(signUpMemberRequest.getAge())
                .gender(signUpMemberRequest.getGender())
                .exerciseGoal(signUpMemberRequest.getExerciseGoal())
                .build());

        return AuthResponse.builder()
                .isNewMember(false)
                .memberId(member.getId())
                .socialId(member.getSocialId())
                .name(member.getName())
                .email(member.getEmail())
                .profileImageUrl(member.getProfileImageUrl())
                .age(member.getAge())
                .gender(member.getGender())
                .exerciseGoal(member.getExerciseGoal())
                .build();
    }
}
