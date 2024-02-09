package beyondvision.routine.controller;

import beyondvision.routine.dto.request.RoutinePostRequest;
import beyondvision.routine.service.RoutineService;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/exercise")
public class RoutineController {

    private final RoutineService routineService;

    @PostMapping("routine/register/{memberId}")
    public ResponseEntity<?> postRoutine(@PathVariable("memberId") final Long memberId, RoutinePostRequest routinePostRequest){
        return ResponseEntity.ok().body(routineService.postRoutine(memberId, routinePostRequest));
    }

    @GetMapping("routine/modify/{memberId}")
    public ResponseEntity<?> getRoutine(@PathVariable("memberId") final Long memberId){
        return ResponseEntity.ok().body(routineService.getRoutine(memberId));
    }

    @DeleteMapping("routine/delete/{memberId}/{routineId}")
}
