(in-package :schemer-series/tests)

(def-suite chapter11 :in the-seasoned-schemer)
(in-suite chapter11)

(test two-in-a-row?
  (is-false (let ((lat '(italian sardines spaghetti parsely)))
	     (two-in-a-row? lat)))
  (is-true (let ((lat '(italian sardines sardines spaghetti parsely)))
	     (two-in-a-row? lat)))
  (is-false (let ((lat '(italian sardines more sardines spaghetti)))
	      (two-in-a-row? lat)))
  (is-true (let ((lat '(d e i i a g)))
	     (two-in-a-row? lat))))

(test sum-of-prefixes
  (is (equal? (let ((tup '()))
		(sum-of-prefixes tup))
	      '()))
  (is (equal? (let ((tup '(2 1 9 17 0)))
		(sum-of-prefixes tup))
	      '(2 3 12 29 29)))
  (is (equal? (let ((tup '(1 1 1 1 1)))
		(sum-of-prefixes tup))
	      '(1 2 3 4 5))))

(test scramble
  (is (equal? (let ((tup '()))
		(scramble tup))
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
