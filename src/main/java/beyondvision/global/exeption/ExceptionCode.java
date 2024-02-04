package beyondvision.global.exeption;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Getter
public enum ExceptionCode {

    INVALID_REQUEST(1000, "올바르지 않은 요청입니다."),
    FAIL_TO_GET_GOOGLE_MEMBER(1001, "구글 회원 정보를 가져오지 못했습니다."),
    EXIST_MEMBER(1002, "존재하는 회원입니다."),
    INVALID_MEMBER(1003, "존재하지 않는 유저입니다.");

    private final int code;
    private final String message;
}
