package beyondvision.auth.service;

import beyondvision.global.exeption.BadRequestException;
import beyondvision.member.domain.Member;
import beyondvision.member.domain.repository.MemberRepository;
import beyondvision.member.dto.request.SignUpMemberRequest;
import beyondvision.member.dto.response.signUpResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import static beyondvision.global.exeption.ExceptionCode.EXIST_MEMBER;

@Service
@RequiredArgsConstructor
public class AuthService {
    private final MemberRepository memberRepository;

    public signUpResponse signUp(SignUpMemberRequest signUpMemberRequest) {

        if (!memberRepository.existsBySocialId(signUpMemberRequest.getSocialId()))
            memberRepository.save(new Member(
                    signUpMemberRequest.getName(),
                    signUpMemberRequest.getEmail(),
                    signUpMemberRequest.getSocialId(),
                    signUpMemberRequest.getProfileImageUrl(),
                    signUpMemberRequest.getAge(),
                    signUpMemberRequest.getGender(),
                    signUpMemberRequest.getExerciseGoal()));

        throw new BadRequestException(EXIST_MEMBER);
    }
}
