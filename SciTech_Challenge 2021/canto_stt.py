import speech_recognition as sr

def speech_to_text():
    r = sr.Recognizer()

# recognize from microphone
    with sr.Microphone() as source:
       print('Recording now')
       audio = r.listen(source)

# recognition
    try:
        return(str(r.recognize_google(audio, language='yue')))
    except sr.UnknownValueError:
        print('Unknown Error')
    except sr.RequestError:
        print('Request Error')
