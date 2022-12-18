import clips
import PySimpleGUI as sg

env = clips.Environment()

# load constructs into the environment from a file
env.load('books.clp')


env.reset()
print(env.run())
#environment.run()


template = env.find_template('message')

for rule in env.rules():
    print(rule)


print("----------------")
message = dict(list(template.facts())[0])

env.assert_string('(genre fantasy)')

print(env.run())

for fact in env.facts():
    print(fact)

