(deftemplate message
    (slot name (type STRING))
    (slot question (type STRING))
    (multislot answers (type STRING))
)

(deftemplate book
    (slot author (type STRING))
    (slot title (type STRING))
)


(defrule genre
    =>
    (assert (message (name "genre") (question "Which type of book are you looking for?") (answers "Fantasy" "Sci-fi" "A little bit of both")))
)


;fantasy branch

(defrule fairy-tale
    ?f <- (genre "Fantasy")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fairy-tale") (question "Up for a fairy tale?") (answers "Yes, why mess with classic formula" "No, something more gritty")))
)

(defrule classic-preference
    ?f <- (fairy-tale "Yes, why mess with classic formula")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "classic-preference") (question "Which of the classics do you prefer?") (answers "A gritty, existential fable" "Reverse Rumpelstiltskin" "Goblin Politics" "A short story")))
)

(defrule gritty-fable-result
    ?f <- (classic-preference "A gritty, existential fable")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Kazuo Ishiguro") (title "The Buried Giant")))
)

(defrule 
    ?f <- (classic-preference "Reverse Rumpelstiltskin")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Naomi Novik") (title "Spinning Silver")))
)

(defrule 
    ?f <- (classic-preference "Goblin Politics")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Katherine Addison") (title "The Goblin Emperor")))
)

(defrule short-story
    ?f <- (classic-preference "A short story")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "short-story") (question "The short story should be:") (answers "Based in Asian folklore" "Provocative yet surreal")))
)

(defrule asian-folklore-result
    ?f <- (short-story "Based in Asian folklore")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Ken Liu") (title "The Paper Menagerie And Other Stories")))
)

(defrule provocative-surreal-result
    ?f <- (short-story "Provocative yet surreal")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Carmen Maria Machado") (title "Her Body and Other Parties")))
)


(defrule society-change
    ?f <- (fairy-tale "No, something more gritty")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "society-change") (question "Society on the brink of change?") (answers "Yes, bring on the new world" "No, not that gritty")))
)

(defrule land-change
    ?f <- (society-change "Yes, bring on the new world" )
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "land-change") (question "What's changing the land?") (answers "Once in an age events" "Magical Revolution")))
)


(defrule age-events
    ?f <- (land-change "Once in an age events")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "age-events") (question "What events change the land?") (answers "Geological and caste upheaval" "Celestial events in an unbalanced world")))
)

(defrule geo-caste-upheaval-result
    ?f <- (age-events "Geological and caste upheaval")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "N.K. Jemisin") (title "The Fifth Season")))
)

(defrule celestial-events-result
    ?f <- (age-events "Celestial events in an unbalanced world")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Rebecca Roanhorse") (title "Black Sun")))
)

(defrule magical-revolution
    ?f <- (land-change "Magical Revolution")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "magical-revolution") (question "How is magic changing the world?") (answers "A monopoly over magical jade" "New magic and ghostly intrigue" "Magic giving way to machines")))
)

(defrule jade-monopoly-result
    ?f <- (magical-revolution "A monopoly over magical jade")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Fonda Lee") (title "Jade City")))
)

(defrule ghostly-intrigue-result
    ?f <- (magical-revolution "New magic and ghostly intrigue")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Sofia Samatar") (title "A Stranger un Olondria")))
)

(defrule machines-result
    ?f <- (magical-revolution "Magic giving way to machines")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Joe Abercrombie") (title "A Little Haterd")))
)



(defrule show-running
    ?f <- (society-change "No, not that gritty")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "show-running") (question "Who's running the show?") (answers "The Gods" "The People")))
)

(defrule gods-involvement 
    ?f <- (show-running "The Gods")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "gods-involvement") (question "How are the gods involved?") (answers "Gods cohabiting hosts" "Gods being overthrowed" "Gods among us")))
)

(defrule gods-cohabiting-result
    ?f <- (gods-involvement "Gods cohabiting hosts")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "R.T.Kuang") (title "The Poppy War")))
)

(defrule overthrowed-gods-result
    ?f <- (gods-involvement "Gods being overthrowed")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Robert Jackson Bennet") (title "City of Stairs")))
)

(defrule gods-among-us
    ?f <- (gods-involvement "Gods among us")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "gods-among-us") (question "In what way are gods among us?") (answers "The Odyssey from a goddess' point of view" "Creating a utopia" "With shapeshifters")))
)

(defrule odyssey-result
    ?f <- (gods-among-us "The Odyssey from a goddess' point of view")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Madeline Miller") (title "Circe")))
)

(defrule utopia-result
    ?f <- (gods-among-us "Creating a utopia")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Jo Walton") (title "The Just City")))
)

(defrule shapeshifters-result
    ?f <- (gods-among-us "With shapeshifters")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Marlon James") (title "Black Leopard, Red Wolf")))
)

(defrule travel
    ?f <- (show-running "The People")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "travel") (question "Want to travel somewhere?") (answers "Yes, to a time in the past" "Yes, to somewhere with magical borders" "No")))
)

(defrule no-travel-result
    ?f <- (travel "No")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Seanan McGuire") (title "Every Heart A Doorway")))
)

(defrule in-past
    ?f <- (travel "Yes, to a time in the past")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "in-past") (question "What kind of place in the past?") (answers "Egypt steeped in magic" "With a magic swindler" "With a magic mapmaker")))
)


(defrule travel-past-egipy-result
    ?f <- (in-past "Egypt steeped in magic")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "P. Djeli Clark") (title "A Master of Djinn")))
)

(defrule magic-swindler-result
    ?f <- (in-past "With a magic swindler")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "S.A. Chakraborty") (title "The City of Brass")))
)

(defrule magic-mapmaker-result
    ?f <- (in-past "With a magic mapmaker")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "G. Willow Wilson") (title "The Bird King")))
)

(defrule magical-borders
    ?f <- (travel "Yes, to somewhere with magical borders")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "magical-borders") (question "Are you sure you want magical borders?") (answers "Perhaps?" "Yes, bring on the new world")))
)

(defrule perhaps-magical-borders-result
    ?f <- (magical-borders "Perhaps?")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Susanna Clarke") (title "Piranesi")))
)

(defrule new-world
    ?f <- (magical-borders "Yes, bring on the new world")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "new-world") (question "Where do you want to go?") (answers "To other Earths" "To find why magic dried up" "To a magical New York City")))
)

(defrule other-earths-result
    ?f <- (new-world "To other Earths")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "V.E.Schwab") (title "A Darker Shade of Magic")))
)

(defrule magic-dried-up-result
    ?f <- (new-world "To find why magic dried up")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Zen Cho") (title "Sorcerer to the Crown")))
)

(defrule magical-NY-result
    ?f <- (new-world "To a magical New York City")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Victor LaValle") (title "The Changeling")))
)

;both branch

(defrule genre-mix-preference
    ?f <- (genre "A little bit of both")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "genre-mix-preference") (question "Which do you prefer?") (answers "A bit of horror" "Alternative history")))
)

(defrule horror
    ?f <- (genre-mix-preference "A bit of horror")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "horror") (question "What type of horror?") (answers "Dark and omnious" "Religious horror in space")))
)

(defrule horror-dark-result
    ?f <- (horror "Dark and omnious")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Silvia Moreno-Garcia") (title "Mexican Gothic")))
)

(defrule horror-in-space-result
    ?f <- (horror "Religious horror in space")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Tamsyn Muir") (title "Gideon The Ninth")))
)

(defrule alternative-history
    ?f <- (genre-mix-preference "Alternative history")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "alternative-history") (question "Where should the alternative history take place?") (answers "In the past" "In the present" "In the future")))
)

(defrule alternative-in-past-result
    ?f <- (alternative-history "In the past")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Robinette Kowal") (title "The Calculating Stars")))
)


(defrule pandemic-too-soon
    ?f <- (alternative-history "In the present")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "pandemic-too-soon") (question "Too soon for a pandemic?") (answers "Yes" "No")))
)

(defrule pandemic-result
    ?f <- (pandemic-too-soon "No")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Emily St. John Mandel") (title "Station Eleven")))
)

(defrule instead-of-pandemic
    ?f <- (pandemic-too-soon "Yes")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "instead-of-pandemic") (question "Which would you rather do?") (answers "Escape political unrest" "Start-revolution")))
)

(defrule political-unrest-result
    ?f <- (instead-of-pandemic "Escape political unrest")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "E. Lily Yu") (title "On Fragile Waves")))
)

(defrule revolution-result
    ?f <- (instead-of-pandemic "Start-revolution")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Tochi Onyebuchi") (title "Riot Baby")))
)

(defrule fighting-in-the-future
    ?f <- (alternative-history "In the future")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fighting-in-the-future") (question "What would you rather fight?") (answers "Imperialism" "Climate change")))
)

(defrule imperialism-result
    ?f <- (fighting-in-the-future "Imperialism")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Seth Dickinson") (title "The Traitor Baru Cormorant")))
)

(defrule climate-change-result
    ?f <- (fighting-in-the-future "Climate change")
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (book (author "Omar El Akkad") (title "American War")))
)