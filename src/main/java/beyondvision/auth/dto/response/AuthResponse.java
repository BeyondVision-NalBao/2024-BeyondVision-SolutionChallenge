package beyondvision.auth.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

import static lombok.AccessLevel.PRIVATE;

@Getter
@RequiredArgsConstructor(access = PRIVATE)
public class AuthResponse {

    private final String name;
    private final String email;
    private final String socialId;
    private final String profileImageUrl;
    private final Boolean isNewMember;

    @Builder
    public static AuthResponse of(
            final String socialId,
            final String name,
            final String email,
            final String profileImageUrl,
            final Boolean isNewMember
    ) {
        return new AuthResponse(
                socialId,
                name,
                email,
                profileImageUrl,
                isNewMember
        );
    }
}
