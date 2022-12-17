import clips

environment = clips.Environment()

# load constructs into the environment from a file
environment.load('books.clp')


environment.reset()
environment.run()
environment.run()

for rule in environment.rules():
    print(rule)

for fact in environment.facts():
    print(fact)

