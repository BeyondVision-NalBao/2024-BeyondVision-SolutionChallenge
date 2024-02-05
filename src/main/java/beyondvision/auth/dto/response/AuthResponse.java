package beyondvision.auth.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

import static lombok.AccessLevel.PRIVATE;

@Getter
@RequiredArgsConstructor(access = PRIVATE)
public class AuthResponse {

    private final Long memberId;
    private final String name;
    private final String email;
    private final String socialId;
    private final String profileImageUrl;
    private final Integer age;
    private final String gender;
    private final Integer exerciseGoal;
    private final Boolean isNewMember;

    @Builder
    public static AuthResponse of(
            final Long memberId,
            final String name,
            final String email,
            final String socialId,
            final String profileImageUrl,
            final Integer age,
            final String gender,
            final Integer exerciseGoal,
            final Boolean isNewMember
    ) {
        return new AuthResponse(
                memberId,
                name,
                email,
                socialId,
                profileImageUrl,
                age,
                gender,
                exerciseGoal,
                isNewMember
        );
    }
}
