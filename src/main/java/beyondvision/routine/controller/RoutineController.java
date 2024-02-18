package beyondvision.routine.controller;

import beyondvision.routine.dto.request.RoutineRequest;
import beyondvision.routine.service.RoutineService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/exercise")
public class RoutineController {

    @Autowired
    private final RoutineService routineService;

    @ResponseBody
    @PostMapping("/routine/register/{memberId}")
    public ResponseEntity<?> postRoutine(@PathVariable("memberId") final Long memberId, @RequestBody final RoutineRequest routinePostRequest, HttpServletRequest request){
        System.out.println("Request Content-Type: " + request.getContentType());
        System.out.println("Request Body: " + routinePostRequest.getRoutineName());
        return ResponseEntity.ok().body(routineService.postRoutine(memberId, routinePostRequest));
    }

    @GetMapping("/routine/detail/{memberId}")
    public ResponseEntity<?> getRoutine(@PathVariable("memberId") final Long memberId){
        return ResponseEntity.ok().body(routineService.getRoutine(memberId));
    }

    @PutMapping("/routine/modify/{memberId}/{routineId}")
    public ResponseEntity<?> putRouine(@PathVariable("memberId") final Long memberId, @PathVariable("routineId") final Long routineId, @RequestBody RoutineRequest routinePutRequest){
        return ResponseEntity.ok().body(routineService.putRoutine(memberId, routineId, routinePutRequest));
    }

    @DeleteMapping("/routine/delete/{memberId}/{routineId}")
    public ResponseEntity<?> deleteRoutine(@PathVariable("memberId") final Long memberId, @PathVariable("routineId") final Long routineId){
        routineService.deleteRoutine(memberId, routineId);
        return ResponseEntity.ok().build();
    }
}
