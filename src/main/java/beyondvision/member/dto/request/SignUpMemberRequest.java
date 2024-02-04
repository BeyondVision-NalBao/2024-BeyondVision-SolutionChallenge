package beyondvision.member.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class SignUpMemberRequest {

    @NotNull(message = "사용자의 이름은 필수입니다.")
    private String name;

    private String email;

    @NotNull(message = "사용자의 소셜 아이디는 필수입니다.")
    private String socialId;

    private String profileImageUrl;
    private Integer age;
    private String gender;
    private Integer exerciseGoal;
}
