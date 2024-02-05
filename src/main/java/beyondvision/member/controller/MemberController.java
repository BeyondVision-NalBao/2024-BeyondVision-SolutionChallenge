package beyondvision.member.controller;

import beyondvision.auth.service.AuthService;
import beyondvision.auth.service.GoogleAuthService;
import beyondvision.member.dto.request.SignUpMemberRequest;
import beyondvision.member.dto.request.UpdateMemberProfileRequest;
import beyondvision.member.service.MemberService;
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
    public final MemberService memberService;

    @GetMapping("/google/{accessToken}")
    public ResponseEntity<?> googleLogin(@PathVariable(name = "accessToken") String accessToken) {
        return ResponseEntity.ok().body(googleAuthService.googleLogin(accessToken));
    }

    @PostMapping(value = "/signup")
    public ResponseEntity<?> signup(@RequestBody @Valid SignUpMemberRequest signUpMemberRequest) {
        authService.signUp(signUpMemberRequest);
        return ResponseEntity.ok().build();
    }

    @GetMapping(value = "/profile/{memberId}")
    public ResponseEntity<?> getProfile(@PathVariable(name = "memberId") Long memberId) {
        return ResponseEntity.ok().body(memberService.getMemberProfile(memberId));
    }

    @PostMapping(value = "/profile/{memberId}")
    public ResponseEntity<?> updateProfile(
            @PathVariable(name = "memberId") Long memberId,
            @RequestBody UpdateMemberProfileRequest updateMemberProfileRequest
    ) {
        return ResponseEntity.ok().body(memberService.updateMemberProfile(memberId, updateMemberProfileRequest));
    }
}
