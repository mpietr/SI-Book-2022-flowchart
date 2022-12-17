import clips
import PySimpleGUI as sg

env = clips.Environment()

# load constructs into the environment from a file
env.load('books.clp')


env.reset()
env.run()
#environment.run()


template = env.find_template('message')

message = dict(list(template.facts())[0])

print(message)

radio_buttons = [[sg.Radio('', 1, key=k), sg.Text(k, pad=(0,0), key=str('t' + k))] for k in message['answers']]

layout = [
    [sg.Text(message['question'], font=('Helvetica', 16))],
    radio_buttons,
    [sg.Submit()]
]

window = sg.Window("2022 Book Discovery", layout, size=(600, 400))


while True:
    event, values = window.read()

    if event == sg.WINDOW_CLOSED:
        break
    elif event == 'Submit':
        old_keys = message['answers']
        value = [x for x, y in values.items() if y == True][0]
        print(value)
        env.assert_string('({} {})'.format(message['name'], value))
        print('({} {})'.format(message['name'], value))
        message = dict(list(template.facts())[0])
        print(message)
        [window[k].update(value=nk) for k, nk in zip(old_keys, message['answers'])]

