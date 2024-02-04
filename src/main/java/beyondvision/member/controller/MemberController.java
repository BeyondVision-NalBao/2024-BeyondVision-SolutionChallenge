package beyondvision.member.controller;

import beyondvision.auth.service.GoogleAuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/member")
public class MemberController {

    public final GoogleAuthService googleAuthService;

    @GetMapping("/google/{accessToken}")
    public ResponseEntity<?> googleLogin(@PathVariable(name = "accessToken") String accessToken) {
        return ResponseEntity.ok().body(googleAuthService.googleLogin(accessToken));
    }
}
