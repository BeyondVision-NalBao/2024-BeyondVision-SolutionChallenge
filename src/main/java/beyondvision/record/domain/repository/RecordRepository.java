package beyondvision.record.domain.repository;

import beyondvision.record.domain.Record;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface RecordRepository extends JpaRepository<Record, Long> {

    @Query(value = """
            SELECT record
            FROM Record record
            WHERE record.member.id = :memberId 
            AND record.createdTime >= DATE_ADD(NOW(), INTERVAL - 3 MONTH)
            """, nativeQuery = true)
    List<Record> getRecordByMemberIdBetween(@Param("memberId") final Long memberId);
}
