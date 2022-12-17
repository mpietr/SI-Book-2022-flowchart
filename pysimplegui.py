
import PySimpleGUI as sg

EXTNS = ['JPG', 'ARW', 'TIF', 'DNG', 'PNG', 'PSD', 'All']

#form = sg.FlexForm('Duplicate File Finder')



radio_buttons = [[sg.Radio('', 1, key='-b1-'), sg.Text('test', pad=(0,0), key='t')],
                    [sg.Radio(EXTNS[1], 1, key=EXTNS[1])],
                    [sg.Radio(EXTNS[2], 1, key=EXTNS[2])] ]
                    
layout = [
    [sg.Text('Select a file extension for the search:', size=(30, 1),
            font=("Helvetica", 25))],
    radio_buttons,
    [sg.Submit(), sg.Cancel()]
]

window = sg.Window("tytul", layout, size=(600, 400))

while True:

    button, values = window.read()
    window['-b1-'].update(value="test")

    if button == "Submit":
        window['t'].update(value="test2")
        print(values)
    if button == "Cancel":
        break

# def show_window(text, labels, keys):
#     radio_buttons = []
#     for i in range(len(labels)):
#         radio_buttons.append([sg.Radio(labels[i], 1, key=keys[i])])
#     layout = [
#     [sg.Text(text, size=(30, 1),
#              font=("Helvetica", 25))],
#     radio_buttons,
#     [sg.Button('Next'), sg.Cancel()]
# ]

# while True:
#     event, values = form.Layout(layout).Read()
#     print(event, values)
#     if event in  (None, 'Exit'):
#         break
#     if event == 'Show':
#         # Update the "output" text element to be the value of "input" element
#         window['-OUTPUT-'].update(values['-IN-'])

