package beyondvision.auth.service;

import beyondvision.auth.dto.response.AuthResponse;
import beyondvision.auth.dto.response.GoogleMemberInfoResponse;
import beyondvision.global.exeption.AuthException;
import beyondvision.member.domain.Member;
import beyondvision.member.domain.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
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
    @Value("${oauth2.google.user-base-url}")
    private String GOOGLE_USER_BASE_URL;

    public AuthResponse googleLogin(String accessToken) {
        GoogleMemberInfoResponse googleMember = getGoogleMemberInfo(accessToken);

        Member member = memberRepository.findMemberBySocialId(googleMember.getId());

        if (member == null) {
            AuthResponse.builder()
                    .isNewMember(true)
                    .socialId(googleMember.getId())
                    .name(googleMember.getName())
                    .email(googleMember.getEmail())
                    .build();
        }

        return AuthResponse.builder()
                .isNewMember(true)
                .socialId(member.getSocialId())
                .name(member.getName())
                .email(member.getEmail())
                .build();
    }

    public GoogleMemberInfoResponse getGoogleMemberInfo(String accessToken) {
        GoogleMemberInfoResponse googleMemberInfo = webClient.get()
                .uri(GOOGLE_USER_BASE_URL, uriBuilder -> uriBuilder.queryParam("access_token", accessToken).build())
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
