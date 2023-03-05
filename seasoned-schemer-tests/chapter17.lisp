(in-package :schemer-series/tests)

(def-suite chapter17 :in the-seasoned-schemer)
(in-suite chapter17)

(test deep-M
  (is (eqlist? (let ((n 3))
		 (deep-M n))
	       `(((,schemer-series::'pizza))))))

(test deep-C
  (is (eqlist? (let ((n 5))
		 (setq schemer-series::*counter* 0)
		(deep-C n))
	      `(((((,schemer-series::'pizza)))))))
  (is (equal? (let ((n 7))
		(deep-C n)
		schemer-series::*counter*)
	      12)))

(test consC
  (is (eq? (let ((x 2) (y '()))
	     (setq schemer-series::*counter* 0)
	     (consC x y)
	     schemer-series::*counter*)
	   1)))

(test supercounter
  (is (equal? (let ((f #'deep-C))
		;; setup
		(setq schemer-series::*counter* 0)
		(supercounter f))
	      500500)))

(test rember1*C
  (is (eqlist? (let ((a 2) (l '(1 3 4 2 4 3 (2 3 4))))
		 (rember1*C a l))
	       '(1 3 4 4 3 (2 3 4))))
  (is (eqlist? (let ((a 'noodles) (l '((food) more (food))))
		 (rember1*C a l))
	       '((food) more (food)))))

(test rember1*C2
  (is (equal? (let ((a 'noodles)
		    (l '((food) more (food))))
		(setq schemer-series::*counter* 0)
		(rember1*C2 a l)
		schemer-series::*counter*)
	      5)))
