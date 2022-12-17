(deffacts questions
    (q1 "Which type of book are you looking for?")

)

(defrule start
    ?f <- (q1 ?x)
    =>
    (assert (send ?x))
)

(defrule test
    =>
    (assert (testujemy))
)

