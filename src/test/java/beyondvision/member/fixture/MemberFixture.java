package beyondvision.member.fixture;

import beyondvision.member.domain.Member;

public class MemberFixture {

    public static final Member MEMBER_1 = Member.builder()
            .name("이름")
            .email("이름@mail.com")
            .socialId("socialId")
            .profileImageUrl("https://~")
            .age(20)
            .gender("여")
            .exerciseGoal(60)
            .build();
}
