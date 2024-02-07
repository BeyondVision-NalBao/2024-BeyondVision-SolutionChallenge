package beyondvision.auth.service;

import beyondvision.auth.dto.response.AuthResponse;
import beyondvision.auth.dto.response.GoogleMemberInfoResponse;
import beyondvision.global.exeption.AuthException;
import beyondvision.member.domain.Member;
import beyondvision.member.domain.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatusCode;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import static beyondvision.global.exeption.ExceptionCode.FAIL_TO_GET_GOOGLE_MEMBER;

@Service
@RequiredArgsConstructor
public class GoogleAuthService {

    private final MemberRepository memberRepository;
    private final WebClient webClient;

    public AuthResponse googleLogin(String accessToken) {
        GoogleMemberInfoResponse googleMember = getGoogleMemberInfo(accessToken);

        final Member member = memberRepository.findMemberBySocialId(googleMember.getId()).orElse(null);

        if (member == null) {
            return AuthResponse.builder()
                    .isNewMember(true)
                    .socialId(googleMember.getId())
                    .name(googleMember.getName())
                    .email(googleMember.getEmail())
                    .profileImageUrl(googleMember.getPicture())
                    .build();
        }

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

    public GoogleMemberInfoResponse getGoogleMemberInfo(String accessToken) {
        GoogleMemberInfoResponse googleMemberInfo = webClient.get()
                .uri("https://www.googleapis.com/oauth2/v1/userinfo", uriBuilder -> uriBuilder.queryParam("access_token", accessToken).build())
                .retrieve()
                .onStatus(HttpStatusCode::is4xxClientError, response -> Mono.error(new RuntimeException("Social Access Token is unauthorized")))
                .onStatus(HttpStatusCode::is5xxServerError, response -> Mono.error(new RuntimeException("Internal Server Error")))
                .bodyToMono(GoogleMemberInfoResponse.class)
                .flux()
                .toStream()
                .findFirst()
                .orElseThrow(() -> new AuthException(FAIL_TO_GET_GOOGLE_MEMBER));

        return googleMemberInfo;
    }
}
