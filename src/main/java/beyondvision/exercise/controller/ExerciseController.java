package beyondvision.exercise.controller;

import beyondvision.exercise.dto.request.ExerciseRecordRequest;
import beyondvision.exercise.service.ExerciseService;
import beyondvision.record.service.RecordService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/exercise")
public class ExerciseController {

    private final RecordService recordService;
    private final ExerciseService exerciseService;

    @PostMapping("/record/{memberId}")
    public ResponseEntity<?> saveExerciseRecord(@PathVariable("memberId") final Long memberId, @RequestBody @Valid final ExerciseRecordRequest exerciseRecordRequest) {
        return ResponseEntity.ok().body(recordService.saveExerciseRecord(memberId, exerciseRecordRequest));
    }

    @GetMapping("/detail/{categoryNumber}")
    public ResponseEntity<?> getExerciseDetail(@PathVariable("categoryNumber") final Integer categoryNumber) {
        return ResponseEntity.ok().body(exerciseService.getExerciseDetailByCategory(categoryNumber));
    }
}
