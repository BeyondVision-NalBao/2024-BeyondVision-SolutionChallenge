package beyondvision.member;

import beyondvision.detail.domain.RoutineDetail;
import beyondvision.detail.domain.repository.RoutineDetailRepository;
import beyondvision.exercise.domain.Exercise;
import beyondvision.exercise.domain.repository.ExerciseRepository;
import beyondvision.member.domain.Member;
import beyondvision.member.domain.repository.MemberRepository;
import beyondvision.member.service.MemberService;
import beyondvision.routine.domain.Routine;
import beyondvision.routine.domain.repository.RoutineRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class MemberServiceTest {

    @Autowired
    MemberService memberService;

    @Autowired
    MemberRepository memberRepository;

    @Autowired
    ExerciseRepository exerciseRepository;

    @Autowired
    RoutineRepository routineRepository;

    @Autowired
    RoutineDetailRepository routineDetailRepository;

    @Test
    public void signOut() {
        final Member member = memberRepository.findMemberById(1L).get();
        final Exercise exercise = exerciseRepository.findExerciseById(1L).get();
        Routine routine = new Routine("나의 루틴", member);
        RoutineDetail routineDetail = new RoutineDetail(1L, 10, 0, routine, exercise);

        routineRepository.save(routine);
        routineDetailRepository.save(routineDetail);


    }
}
