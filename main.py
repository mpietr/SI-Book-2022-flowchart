import clips
import PySimpleGUI as sg


MAX = 4
WIDTH = 500
HEIGHT = 300

env = clips.Environment()

# load constructs into the environment from a file
env.load('books.clp')


env.reset()
env.run()
#environment.run()


msg_template = env.find_template('message')

message = dict(list(msg_template.facts())[0])

print(message)

button_keys = ['button0', 'button1', 'button2', 'button3', 'button4']
text_keys = ['text0', 'text1', 'text2', 'text3', 'text4']

options = message['answers']
s = len(options)

#radio_buttons = [[sg.Radio('', 1, key=b), sg.Text(k if text_keys.index(t) < 3 else '', pad=(0,0), key=t)] for b,t,k in zip(button_keys, text_keys, message['answers'])]
radio_buttons = [[sg.Radio('', 1, key=button_keys[i], visible=(i < 3), default=(i == -1)), sg.Text(options[i] if i < 3 else '', pad=(0,0), key=text_keys[i])] for i in range(MAX)]

layout = [
    [sg.Text(message['question'], font=('Helvetica', 16), key='q')],
    radio_buttons,
    [sg.Button('Submit')]
]



window = sg.Window("2022 Book Discovery", layout, size=(WIDTH, HEIGHT))



while True:
    event, values = window.read()

    if event == sg.WINDOW_CLOSED:
        break
    elif event == 'Submit':
        if len([x for x, y in values.items() if y == True]) > 0:
            value = [x for x, y in values.items() if y == True][0]
            env.assert_string('({} "{}")'.format(message['name'], message['answers'][button_keys.index(value)]))
            env.run()

            message_list = list(msg_template.facts())

            #if list is not empty
            if message_list:

                message = dict(message_list[0])
                print(message)
                window['q'].update(value=message['question'])

                options = message['answers']
                n = len(options)

                for i in range(MAX):
                    print(n, i)
                    if i < n:
                        window[button_keys[i]].update(visible=True)
                        window[text_keys[i]].update(value=options[i], visible=True)
                        print(text_keys[i], options[i])
                        print("visible")
                    else:
                        print("invisible")
                        window[text_keys[i]].update(visible=False)
                        window[button_keys[i]].update(visible=False)
            else:
                window.close()
                break


env.run()

res_template = env.find_template('book')

result = dict(list(res_template.facts())[0])


result_layout = [
    [sg.Text(result['title'], font='Any 20', pad=(10,10))],
    [sg.Text(result['author'], font='Any 15')],
    [sg.Button("Close", size=(10,2), pad=(30,30))]
]

result_window = sg.Window("Discovered book", result_layout, size=(WIDTH, 200), element_justification='c')

while True:
    event, values = result_window.read()

    if event == sg.WINDOW_CLOSED or event == "Close":
        break



