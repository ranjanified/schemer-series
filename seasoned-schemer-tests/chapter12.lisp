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
