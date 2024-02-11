import speech_recognition as sr


def sttFunction():
    while True:
        r = sr.Recognizer()

        with sr.Microphone() as source:
            audio = r.listen(source, 10, 3)

        # 구글 웹 음성 API로 인식하기 (하루에 제한 50회)
        try:
            result = r.recognize_google(audio, language='ko')
        except sr.UnknownValueError:
            continue
        except sr.RequestError as e:
            continue
        print(result)

        # 결과
        if '일번' in result or '1번' in result or '1' in result or '일' in result:
            return 1
        elif '이번' in result or '2번' in result or '2' in result:
            return 2
        elif '삼번' in result or '3번' in result or '3' in result or '삼' in result:
            return 3
        else:
            print('다시 말하세요.')
