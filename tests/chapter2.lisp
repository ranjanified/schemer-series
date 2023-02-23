(in-package :schemer-series/tests)

(def-suite chapter2 :in the-little-schemer)
(in-suite chapter2)

(test member?
  (is-false (let ((lat '(bagels and lox)) (a 'liver))(member? a lat)))
  (is-true (let ((lat '(meat gravy)) (a 'meat))(member? a lat)))
  (is-true (let ((lat '(mashed potatoes and meat gravy)) (a 'meat))(member? a lat)))
  (is-false (let ((lat '(fried eggs and scrambled eggs)) (a 'poached))(member? a lat)))
  (is-true (let ((lat '(coffee tea or milk)) (a 'tea))(member? a lat))))

(test lat?
  (is-false (let ((l '(bacon (and eggs))))(lat? l)))
  (is-true (let ((l '(bacon and eggs)))(lat? l)))
  (is-true (lat? '()))
  (is-false (let ((l '(Jack (Sprat could) eat no chicken fat)))(lat? l)))
  (is-true (let ((l '(Jack Sprat could eat no chicken fat)))(lat? l)))
  (is-false (let ((l '((Jack) Sprat could eat no chicken fat)))(lat? l)))
  (is-false (let ((l '(((tomato sauce))
		       ((bean) sauce)
		       (and ((flying)) sauce)) ))
	      (lat? l))))

(test or
  (is-false (let ((l1 '(a b c)) (l2 '(atom)))(or (null? l1) (null? l2))))
  (is-true (let ((l1 '(a b c)) (l2 '()))(or (null? l1) (null? l2))))
  (is-true (let ((l1 '()) (l2 '(d e f g)))(or (null? l1) (atom? l2)))))
