;;; Chapter 14
(in-package :schemer-series)

(defun left-most* (l)
  (cond
    ((null? l) '())
    ((atom? (car l)) (car l))
    (t
     (let ((a (left-most* (car l))))
       (cond
	 ((atom? a) a)
	 (t (left-most* (cdr l))))))))


(defun remberl* (a l)
  (labels ((L (l)
	     (cond
	       ((null? l) '())
	       ((atom? (car l))
		(cond
		  ((eq? (car l) a) (cdr l))
		  (t (cons (car l) (L (cdr l))))))
	       (t (let ((b (L (car l))))
		    (cond
		      ((eqlist? b (car l)) (cons (car l) (L (cdr l))))
		      (t (cons b (cdr l)))))))))
    (L l)))

(defun depth* (l)
  (cond
    ((null? l) 1)
    ((atom? (car l)) (depth* (cdr l)))
    (t
     (let ((dcar (add1 (depth* (car l))))
	   (dcdr (depth* (cdr l))))
       (max dcar dcdr)))))

(defun rm (a l oh)
  (cond
    ((null? l) (throw oh "no"))
    ((atom? (car l))
     (if (eq? a (car l))
	 (cdr l)
	 (cons (car l) (rm a (cdr l) oh))))
    (t
     (if (atom? (catch oh (rm a (car l) oh)))
	 (cons (car l) (rm a (cdr l) oh))
	 (cons (rm a (car l) oh) (cdr l))))))
