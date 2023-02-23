(in-package :schemer-series/tests)

(def-suite chapter9 :in the-little-schemer)
(in-suite chapter9)

(test looking
  (is-true (let ((a 'caviar) (lat '(6 2 4 caviar 5 7 3)))
	     (looking a lat)))
  ;; (is-false (let ((a 'caviar)
  ;; 		 (lat '(7 1 2 caviar 5 6 3)))
  ;; 	     (looking a lat)))
  )

(test shift
  (is (equal? (let ((x '((a b) c)))
		(shift x))
	      '(a (b c))))
  (is (equal? (let ((x '((a b)(c d))))
		(shift x))
	      '(a (b (c d))))))

(test weight*
  (is (equal? (let ((pora '((a b) c)))
		(weight* pora))
	      7))
  (is (equal? (let ((pora '(a (b c))))
		(weight* pora))
	      5))
  (is (equal? (let ((pora '(((a b) c) (d e))))
		(weight* pora))
	      17)))

(test shuffle
  (is (equal? (let ((pora '(a (b c))))
		(shuffle pora))
	      '(a (b c))))
  (is (equal? (let ((pora '(a b)))
		(shuffle pora))
	      '(a b))))
