import clips
import PySimpleGUI as sg

MAX = 3

env = clips.Environment()

# load constructs into the environment from a file
env.load('books.clp')


env.reset()
env.run()
#environment.run()


template = env.find_template('message')

message = dict(list(template.facts())[0])

print(message)

button_keys = ['button1', 'button2', 'button3']
text_keys = ['text1', 'text2', 'texts']

radio_buttons = [[sg.Radio('', 1, key=b), sg.Text(k, pad=(0,0), key=t)] for b,t,k in zip(button_keys, text_keys, message['answers'])]

layout = [
    [sg.Text(message['question'], font=('Helvetica', 16), key='q')],
    radio_buttons,
    [sg.Submit()]
]

window = sg.Window("2022 Book Discovery", layout, size=(600, 400))


while True:
    event, values = window.read()

    if event == sg.WINDOW_CLOSED:
        break
    elif event == 'Submit':
        value = [x for x, y in values.items() if y == True][0]
        env.assert_string('({} {})'.format(message['name'], message['answers'][button_keys.index(value)]))
        env.run()
        print('({} {})'.format(message['name'], message['answers'][button_keys.index(value)]))
        message = dict(list(template.facts())[0])
        window['q'].update(value=message['question'])

        options = message['answers']
        n = len(options)

        for i in range(MAX):
            if i < n:
                window[text_keys[i]].update(value=options[i])
            else:
                window[text_keys[i]].update(visible=False)
                window[button_keys[i]].update(visible=False)

