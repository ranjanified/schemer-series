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
