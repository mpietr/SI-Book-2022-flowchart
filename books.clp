(deftemplate message
    (slot name (type STRING))
    (slot question (type STRING))
    (multislot answers (type STRING))
)



;(message (name "genre") (question "Which type of book are you looking for?") (answers "fantasy" "sci-fi" "both"))
;(message (name "fairy-tale") (question "Up for a fairy tale?") (answers "Yes, why mess with classic formula" "No, something more gritty"))


(defrule genre
    =>
    (assert (message (name "genre") (question "Which type of book are you looking for?") (answers "fantasy" "Sci-fi" "Both")))
)

(defrule fairy-tale
    ?f <- (genre fantasy)
    ?id <- (message (name ?x))
    =>
    (retract ?id)
    (retract ?f)
    (assert (message (name "fairy-tale") (question "Up for a fairy tale?") (answers "Yes, why mess with classic formula" "No, something more gritty")))
)

