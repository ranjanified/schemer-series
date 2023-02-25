;;; Chapter 12
(in-package :schemer-series)

(defun multi-rember (a lat)
  (funcall (labels ((mr (lat)
		      (cond
			((null? lat) '())
			((eq? a (car lat)) (mr (cdr lat)))
			(t (cons (car lat) (mr (cdr lat)))))))
	     (function mr))
	   lat))

(defun multi-rember-f (test?)
  (labels ((multi-rember (a lat)
	     (cond
	       ((null? lat) '())
	       ((funcall test? a (car lat)) (multi-rember a (cdr lat)))
	       (t (cons (car lat) (multi-rember a (cdr lat)))))))
    (function multi-rember)))

(defun member-? (a lat)
  (labels ((yes? (lat)
	     (cond
	       ((null? lat) nil)
	       ((eq? a (car lat)) t)
	       (t (yes? (cdr lat))))))
    (yes? lat)))

(defun uni-on (set1 set2)
  (labels ((U (lat)
	     (cond
	       ((null? lat) set2)
	       ((M? (car lat) set2) (U (cdr lat)))
	       (t (cons (car lat) (U (cdr lat))))))
	   (M? (a lat)
	     (labels ((N? (lat)
			(cond
			  ((null? lat) nil)
			  ((eq? a (car lat)) t)
			  (t (M? a (cdr lat))))))
	       (N? lat))))
    (U set1)))

(defun protected-two-in-a-row? (lat)
  (labels ((two-in-a-row-b? (a lat)
	     (cond
	       ((null? lat) nil)
	       ((eq? a (car lat)) t)
	       (t (two-in-a-row-b? (car lat) (cdr lat))))))
    (two-in-a-row-b? (car lat) (cdr lat))))

(defun protected-scramble (tup)
  (labels ((scramble-b (prefix tup)
	     (cond
	       ((null? tup) '())
	       (t (cons (pick (car tup) (cons (car tup) prefix))
			(scramble-b (cons (car tup) prefix)
				    (cdr tup)))))))
    (scramble-b '() tup)))
