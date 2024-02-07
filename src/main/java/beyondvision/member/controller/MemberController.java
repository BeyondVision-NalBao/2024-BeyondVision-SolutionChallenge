package beyondvision.member.controller;

import beyondvision.auth.service.AuthService;
import beyondvision.auth.service.GoogleAuthService;
import beyondvision.member.dto.request.SignUpMemberRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/member")
public class MemberController {

    public final GoogleAuthService googleAuthService;
    public final AuthService authService;

    @GetMapping("/google/{accessToken}")
    public ResponseEntity<?> googleLogin(@PathVariable(name = "accessToken") String accessToken) {
        return ResponseEntity.ok().body(googleAuthService.googleLogin(accessToken));
    }

    @PostMapping(value = "/signup")
    public ResponseEntity<?> signup(@RequestBody @Valid SignUpMemberRequest signUpMemberRequest) {
        authService.signUp(signUpMemberRequest);
        return ResponseEntity.ok().build();
    }
}
