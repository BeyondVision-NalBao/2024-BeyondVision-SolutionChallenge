package beyondvision.member.domain.repository;

import beyondvision.member.domain.Member;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberRepository extends JpaRepository<Member, Long> {
    Member findMemberBySocialId(String socialId);
}
