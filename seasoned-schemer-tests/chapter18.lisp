(in-package :schemer-series/tests)

(def-suite chapter18 :in the-seasoned-schemer)
(in-suite chapter18)

(test lots
  (is (eqlist? (let ((m 3))
		 (lots m))
	       '(schemer-series::egg schemer-series::egg schemer-series::egg)))
  (is (eqlist? (let ((m 5))
		 (lots m))
	       '(schemer-series::egg schemer-series::egg schemer-series::egg schemer-series::egg schemer-series::egg))))

(test add-at-end
  (is (eqlist? (let ((l '(123 456)))
		 (add-at-end l))
	       '(123 456 schemer-series::egg)))
  (is (eqlist? (let ()
		 (add-at-end (lots 3)))
	       '(schemer-series::egg schemer-series::egg schemer-series::egg schemer-series::egg))))

(test add-at-end-too
  (is (eqlist? (let ((l '(123 456)))
		 (add-at-end-too l))
	       '(123 456 schemer-series::egg)))
  (is (eqlist? (let ()
		 (add-at-end-too (lots 3)))
	       '(schemer-series::egg schemer-series::egg schemer-series::egg schemer-series::egg))))

;; (test same?
;;   (is-true (let ((c1 (bakers-dozen))
;; 		 (c2 (bakers-dozen)))
;; 	     (same? c1 c2))))

