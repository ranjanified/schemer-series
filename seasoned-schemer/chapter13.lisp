;;; Chapter 13
(in-package :schemer-series)

(defun intersect-all (lset)
  "Intersect All using (letrec ...)"
  (catch 'hop
    (labels ((I (set1 set2)
	       "Intersect"
	       (labels ((In(set1)
			  (cond
			    ((null? set1) '())
			    ((member-? (car set1) set2) (cons (car set1) (In (cdr set1))))
			    (t (In (cdr set1))))))
		 (cond
		   ((null? set2) '())
		   (t (In set1)))))
	     (IA (lset)
	       "Intersect All"
	       (cond
		 ((null? (car lset)) (throw 'hop '()))
		 ((null? (cdr lset)) (car lset))
		 (t (I (car lset) (IA (cdr lset)))))))
      (cond
	((null? lset) '())
	(t (IA lset))))))

(defun rember-beyond-first (a lat)
  (labels ((R (lat)
	     (cond
	       ((null? lat) '())
	       ((eq? a (car lat)) '())
	       (t (cons (car lat) (R (cdr lat)))))))
    (R lat)))

(defun rember-upto-last (a lat)
  (catch 'skip
    (labels ((R (lat)
	       (cond
		 ((null? lat) '())
		 ((eq? a (car lat)) (throw 'skip (R (cdr lat))))
		 (t (cons (car lat) (R (cdr lat)))))))
      (R lat)))
  )
