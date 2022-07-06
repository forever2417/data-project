import pyttsx3

# for MacOS
# engine = pyttsx3.init('nsss')
# voices = engine.getProperty('voices')

# for Windows
engine = pyttsx3.init('sapi5')
voices = engine.getProperty('voices')

# get computer installed voice
#for i, voice in enumerate(voices):
#    print(f"Voice[{i}]: {voice.name}")
#    print(f" - {voice.id}")

engine.setProperty('voice', voices[47].id)
engine.setProperty('rate', 200)
engine.setProperty('volume', 1)

text = 'hello'

engine.say(text)
engine.runAndWait()