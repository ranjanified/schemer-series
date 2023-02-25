(in-package :schemer-series/tests)

(def-suite chapter12 :in the-seasoned-schemer)
(in-suite chapter12)

(test multi-rember
  (is (equal? (let ((a 2)
		    (lat '(5 4 2 3 4 2 5)))
		(multi-rember a lat))
	      '(5 4 3 4 5))))

(test multi-rember-f
  (is (equal? (let ((a 2)
		    (lat '(5 4 2 3 4 2 5))
		    (mr (multi-rember-f #'eq?)))
		(funcall mr a lat))
	      '(5 4 3 4 5))))

(test member-?
  (is-true (let ((a 7)
		 (lat '(1 2 3 4 5 6 7)))
	     (member-? a lat))))

(test uni-on
  (is (equal? (let ((set1 '(1 2 3))
		    (set2 '(4 2 5)))
		(uni-on set1 set2))
	      '(1 3 4 2 5))))

(test protected-two-in-a-row?
  (is-false (let ((lat '(1)))
	     (protected-two-in-a-row? lat)))
  (is-true (let ((lat '(1 2 3 4 5 5 6)))
	     (protected-two-in-a-row? lat))))

(test protected-scramble
  (is (equal? (let ((tup '()))
		(protected-scramble tup))
	      '()))
  (is (equal? (let ((tup '(1 1 1 3 4 2 1 1 9 2)))
		(scramble tup))
	      '(1 1 1 1 1 4 1 1 1 9)))
  (is (equal? (let ((tup '(1 2 3 4 5 6 7 8 9)))
		(scramble tup))
	      '(1 1 1 1 1 1 1 1 1)))
  (is (equal? (let ((tup '(1 2 3 1 2 3 4 1 8 2 10)))
		(scramble tup))
	      '(1 1 1 1 1 1 1 1 2 8 2))))
