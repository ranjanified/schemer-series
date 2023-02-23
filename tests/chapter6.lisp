(in-package :schemer-series/tests)

(def-suite chapter6 :in the-little-schemer)
(in-suite chapter6)

(test numbered?
  (is-true (let ((aexp 1))
	     (numbered? aexp)))
  (is-true (let ((aexp 3))
	     (numbered? aexp)))
  (is-true (let ((aexp '(1 + 3)))
	     (numbered? aexp)))
  (is-true (let ((aexp '(1 + 3 * 4)))
	     (numbered? aexp)))
  (is-true (let ((aexp '(3 + (4 ^ 5))))
	     (numbered? aexp))))

(test value
  (is (= (value 2) 2))
  (is (= (value '(1 + 2)) 3))
  (is (= (value '(1 + (2 * 3) + 7)) 14))
  (is (= (value '(3 ^ 4)) 81)))

(test sero?
  (is-true (sero? '())))

(test edd1
  (is (equal? (edd1 '()) '(())))
  (is (equal? (edd1 '(())) '(() ()))))

(test zub1
  (is (equal? (zub1 '(())) '())))

(test pluz
  (is (equal? (pluz '(()) '(() ())) '(() () ()))))
