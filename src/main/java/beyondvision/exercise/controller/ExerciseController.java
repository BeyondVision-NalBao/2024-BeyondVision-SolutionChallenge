package beyondvision.exercise.controller;

import beyondvision.exercise.dto.request.ExerciseRecordRequest;
import beyondvision.exercise.service.ExerciseService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/exercise")
public class ExerciseController {

    private final ExerciseService exerciseService;

    @PostMapping("/record/{memberId}")
    public ResponseEntity<?> saveExerciseRecord(@PathVariable("memberId") final Long memberId, @RequestBody @Valid final ExerciseRecordRequest exerciseRecordRequest) {
        return ResponseEntity.ok().body(exerciseService.saveExerciseRecord(memberId, exerciseRecordRequest));
    }
}
