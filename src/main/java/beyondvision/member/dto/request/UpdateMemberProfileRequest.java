package beyondvision.member.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class UpdateMemberProfileRequest {

    private String name;
    private Integer age;
    private String gender;
    private Integer exerciseGoal;
}
