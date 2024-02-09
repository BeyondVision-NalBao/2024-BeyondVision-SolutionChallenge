package beyondvision.routine.controller;

import beyondvision.routine.dto.request.RoutineRequest;
import beyondvision.routine.service.RoutineService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/exercise")
public class RoutineController {

    private final RoutineService routineService;

    @PostMapping("routine/register/{memberId}")
    public ResponseEntity<?> postRoutine(@PathVariable("memberId") final Long memberId, RoutineRequest routinePostRequest){
        return ResponseEntity.ok().body(routineService.postRoutine(memberId, routinePostRequest));
    }

    @GetMapping("routine/detail/{memberId}")
    public ResponseEntity<?> getRoutine(@PathVariable("memberId") final Long memberId){
        return ResponseEntity.ok().body(routineService.getRoutine(memberId));
    }

    @PutMapping("routine/modify/{memberId}/{routineId}")
    public ResponseEntity<?> putRouine(@PathVariable("memberId") final Long memberId, @PathVariable("routineId") final Long routineId, RoutineRequest routinePutRequest){
        return ResponseEntity.ok().body(routineService.putRoutine(memberId, routineId, routinePutRequest));
    }

    @DeleteMapping("routine/delete/{memberId}/{routineId}")
    public ResponseEntity<?> deleteRoutine(@PathVariable("memberId") final Long memberId, @PathVariable("routineId") final Long routineId){
        routineService.deleteRoutine(memberId, routineId);
        return ResponseEntity.ok().build();
    }
}
