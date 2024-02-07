package beyondvision.detail.domain.repository;

import beyondvision.detail.domain.RoutineDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface RoutineDetailRepository extends JpaRepository<RoutineDetail, Long> {

    @Modifying
    @Query(value = """
            DELETE FROM RoutineDetail rd
            WHERE rd.routine.member.id = :memberId
            """)
    void deleteAllByMemberId(@Param("memberId") Long memberId);
}
