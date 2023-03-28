(in-package :schemer-series/tests)

(def-suite chapter19 :in the-seasoned-schemer)
(in-suite chapter19)

(test deepB
  (is (eqlist? (let ((m 5))
		 (deepB m))
	       `(((((schemer-series::pizza))))))))

(test start-it
  (is (equal? (let ((l '((potato))))
		(start-it l))
	      'potato)))

;; (test get-next
;;   (is (equal? (let ((x 'go)
;; 		    (l '((donuts) (cheerios (cheerios (spaghettios))) donuts)))
;; 		(start-it2 l)
;; 		(get-next x))
;; 	      'cheerios)))

(test two-in-a-row*?
  (is (equal? (let ((l '(((food) ()) (((food))))))
		(two-in-a-row*? l))
	      t)))
