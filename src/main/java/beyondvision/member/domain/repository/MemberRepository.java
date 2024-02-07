package beyondvision.member.domain.repository;

import beyondvision.member.domain.Member;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MemberRepository extends JpaRepository<Member, Long> {
    Optional<Member> findMemberBySocialId(String socialId);
    Optional<Member> findMemberById(Long memberId);

    boolean existsBySocialId(String socialId);

}
