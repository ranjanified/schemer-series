;;; Chapter 11
(in-package :schemer-series)

(defun is-first? (a lat)
  (cond
    ((null? lat) nil)
    (t (eq? a (car lat)))))

(defun is-first-b? (a lat)
  (cond
    ((null? lat) nil)
    (t (or (eq? a (car lat))
	   (two-in-a-row? lat)))))

(defun two-in-a-row-b? (preceding lat)
  (cond
    ((null? lat) nil)
    (t (or (eq? preceding (car lat))
	   (two-in-a-row-b? (car lat) (cdr lat))))))

(defun two-in-a-row? (lat)
  (cond
    ((null? lat) nil)
    (t (two-in-a-row-b? (car lat) (cdr lat)))))

(defun sum-of-prefixes-b (sum tup)
  (cond
    ((null? tup) '())
    (t (cons (plus sum (car tup))
	     (sum-of-prefixes-b (plus sum (car tup))
				(cdr tup))))))

(defun sum-of-prefixes (tup)
  (cond
    ((null? tup) '())
    (t (sum-of-prefixes-b 0 tup))))

(defun scramble-b (prefix tup)
  (cond
    ((null? tup) '())
    (t (cons (pick (car tup) (cons (car tup) prefix))
	     (scramble-b (cons (car tup) prefix)
			 (cdr tup))))))

(defun scramble (tup)
  (cond
    ((null? tup) '())
    (t (scramble-b '() tup))))
