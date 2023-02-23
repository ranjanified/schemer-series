(in-package :schemer-series/tests)

(def-suite chapter4 :in the-little-schemer)
(in-suite chapter4)

(test number?
  (is-false (number? 'a))
  (is-true (number? 76)))

(test no-nums
  (is (equal? (let ((lats '(5 pears 6 prunes 7 dates)))(no-nums lats))
	      '(pears prunes dates))))

(test all-nums
  (is (equal? (let ((lats '(5 pears 6 prunes 7 dates)))(all-nums lats))
	      '(5 6 7))))

(test equan?
  (is-true (equan? 3 3))
  (is-true (equan? 'a 'a))
  (is-true (equan? "asdf" "asdf")))

(test tup?
  (is-true (let ((l '(15 6 7 12 3))) (tup? l))))

(test zero?
  (is-true (zero? 0))
  (is-false (zero? 1492)))

(test pick
  (is-true (= (pick 2 '(1 2 3 4))
	      2)))

(test rempick
  (is (equal? (let ((n 3) (lat '(hotdogs with hot mustard)))(rempick n lat))
	      '(hotdogs with mustard))))

(test tup+
  (is (equal? (let ((tup1 '(3 7 8 1))
		    (tup2 '(4 6)))
		(tup+ tup1 tup2))
	      '(7 13 8 1)))
(is (equal? (let ((tup1 '(3 7))
		  (tup2 '(4 6)))
	      (tup+ tup1 tup2))
	    '(7 13)))
(is (equal? (let ((tup1 '(2 3))
		  (tup2 '(4 6)))
	      (tup+ tup1 tup2))
	    '(6 9))))

(test addtup
  (is (= (let ((l '(1 2 3 4))) (addtup l)) 10)))

(test greater
  (is-false (let ((m 12) (n 133))(greater m n)))
  (is-true (let ((m 120) (n 11))(greater m n)))
  (is-false (let ((m 6) (n 6))(greater m n))))

(test lesser
  (is-true (let ((m 4) (n 6))(lesser m n)))
  (is-false (let ((m 8) (n 3))(lesser m n)))
  (is-false (let ((m 6) (n 6))(lesser m n))))

(test div
  (is (= (div 15 4) 3)))

(test mul
  (is (= (mul 3 5) 15))
  (is (= (mul 13 4) 52))
  (is (= (mul 12 3) 36)))

(test minus
  (is (= (minus 14 3) 11))
  (is (= (minus 17 9) 8))
  (is (= (minus 18 25) -7)))

(test plus
  (is (= (plus 30 2) 32)))

(test sub1
  (is (= (let ((n 5)) (sub1 n)) 4)))

(test add1
  (is (= (let ((n 67)) (add1 n))) 68))

(test lat-length
  (is (= (lat-length '()) 0))
  (is (= (lat-length '(1)) 1))
  (is (= (lat-length '((1))) 1))
  (is (= (let ((lat '(hotdogs with mustard sauerkraut and pickles))) (lat-length lat))
	 6)))
