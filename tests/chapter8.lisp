(in-package :schemer-series/tests)

(def-suite chapter8 :in the-little-schemer)
(in-suite chapter8)

(test rember-f
  (is (equal? (let ((a 5) (l '(6 2 5 3))
		    (test? #'=))
		(rember-f test? a l))
	      '(6 2 3)))
  (is (equal? (let ((a 'jelly)
		    (l '(jelly beans are good))
		    (test? #'eq?))
		(rember-f test? a l))
	      '(beans are good)))
  (is (equal? (let ((a '(pop corn))
		    (l '(lemonade (pop corn) and (cake)))
		    (test? #'equal?))
		(rember-f test? a l))
	      '(lemonade and (cake)))))

(test eq?-c
  (is-false (let ((x 'tuna) (a 'salad))
	     (funcall (eq?-c x) a))))

(test insertL-f
  (is (equal? (let ((new 15) (old 7) (l '(4 3 6 7 8)))
		(funcall (insertL-f #'=) new old l))
	      '(4 3 6 15 7 8))))

(test insertR-f
  (is (equal? (let ((new 15) (old 7) (l '(4 3 6 7 8)))
		(funcall (insertR-f #'=) new old l))
	      '(4 3 6 7 15 8))))

(test insertS-f
  (is (equal? (let ((new 7) (old 5) (l '(2 4 5 8 6 7)))
		(funcall (insertS-f #'=) new old l))
	      '(2 4 7 8 6 7))))

(test yyy
  (is (equal? (let ((a 'sausage)(l '(pizza with sausage and bacon)))
		(yyy a l))
	      '(pizza with and bacon))))

(test multirember-f
  (is (equal? (let ((a 'tuna) (lat '(shrimp salad tuna salad and tuna))
		    (multirember (multirember-f #'equal)))
		(funcall multirember a lat))
	      '(shrimp salad salad and))))

(test multirember-eq?
  (is (equal? (let ((a 'tuna) (lat '(shrimp salad tuna salad and tuna))
		    (multirember (multirember-eq?)))
		(funcall multirember a lat))
	      '(shrimp salad salad and))))

(test multiremberT
  (is (equal? (let ((test? (function (lambda (a) (eq? a 'tuna))))
		    (lat '(shrimp salad tuna salad and tuna)))
		(multiremberT test? lat))
	      '(shrimp salad salad and))))

(test multirember&Co
  (is (equal? (let ((a 'tuna) (lat '(shrimp salad tuna salad and tuna)))
	     (multirember&Co a lat #'list))
	      '((SHRIMP SALAD SALAD AND) (TUNA TUNA))))

  (is (equal? (let ((a 'tuna)
		    (lat '(strawberries tuna and swordfish))
		    (col (function (lambda (x y)
			   (declare (ignore x))
			   (null? y)))))
	     (multirember&Co a lat col))
	      '()))
  (is (equal? (let ((a 'tuna)
		    (lat '())
		    (a-friend? (lambda (x y)
				 (declare (ignore x))
				 (null? y))))
	     (multirember&Co a lat a-friend?))
	      t))
  (is (equal? (let ((a 'tuna)
		    (lat '(tuna))
		    (a-friend? (lambda (x y)
				 (declare (ignore x))
				 (null? y))))
	     (multirember&Co a lat a-friend?))
	      '()))
  (is (equal? (let ((a 'tuna)
		    (lat '(and tuna))
		    (a-friend? (lambda (x y)
				 (declare (ignore x))
				 (null? y))))
		(let ((new-friend? (lambda (newlat seen)
				    (funcall a-friend? newlat
					       (cons (car lat) seen)))))
		  (multirember&Co a lat new-friend?)))
	      '())))

(test multiinsertLR
  (is (equal? (let ((new 'curry) (oldL 'tuna) (oldR 'swordfish)
		    (lat '(tuna and swordfish)))
		(multiinsertLR new oldL oldR lat))
	      '(curry tuna and swordfish curry))))

(test multiinsertLR&Co
  (is (equal? (let ((new 'cranberries)(oldL 'fish)(oldR 'chips)(lat '())
		    (collector (lambda (lat cl cr)(list lat cl cr))))
		(multiinsertLR&Co new oldL oldR lat collector))
	      '(() 0 0)))
  (is (equal? (let ((new 'series)(oldL 'fish)(oldR 'chips)
		    (lat '(chips and fish or fish and chips))
		    (collector (lambda (lat cl cr)(list lat cl cr))))
		(multiinsertLR&Co new oldL oldR lat collector))
	      '((chips series and series fish or series fish and chips series) 2 2))))

(test evens-only*
  (is (equal? (let ((l '((9 1 2 8) 3 10 ((9 9) 7 6) 2)))
		(evens-only* l))
	      '((2 8) 10 (() 6) 2))))

(test evens-only*&co
  (is (equal? (let ((l '((9 1 2 8) 3 10 ((9 9) 7 6) 2))
		    (collector #'list))
		(evens-only*&Co l collector))
	      '((2 8 10 6 2) 1920 38))))
