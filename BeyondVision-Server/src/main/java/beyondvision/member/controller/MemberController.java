package beyondvision.member.controller;

import beyondvision.auth.service.AuthService;
import beyondvision.auth.service.GoogleAuthService;
import beyondvision.member.dto.request.SignUpMemberRequest;
import beyondvision.member.dto.request.UpdateMemberInfoRequest;
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
        return ResponseEntity.ok().body(authService.signUp(signUpMemberRequest));
    }

    @GetMapping(value = "/info/{memberId}")
    public ResponseEntity<?> getMemberInfo(@PathVariable(name = "memberId") Long memberId) {
        return ResponseEntity.ok().body(memberService.getMemberInfo(memberId));
    }

    @PostMapping(value = "/info/{memberId}")
    public ResponseEntity<?> updateMemberInfo(
            @PathVariable(name = "memberId") Long memberId,
            @RequestBody UpdateMemberInfoRequest updateMemberInfoRequest
    ) {
        return ResponseEntity.ok().body(memberService.updateMemberInfo(memberId, updateMemberInfoRequest));
    }

    @DeleteMapping(value = "/signout/{memberId}")
    public ResponseEntity<?> signOut(@PathVariable(name = "memberId") Long memberId) {
        memberService.signOut(memberId);
        return ResponseEntity.ok().build();
    }
}
