(in-package :schemer-series)

(defun numbered? (aexp)
  (cond
    ((null? aexp) t)
    ((atom? aexp)
     (or
      (number? aexp)
      (and (member? aexp '(^ + - * /)) t)))
    (t (and
	(numbered? (car aexp))
	(numbered? (cdr aexp))))))

(defun value (aexp)
  (cond
    ((atom? aexp) aexp)
    ((equal? (car (cdr aexp)) '+) (plus (value (car aexp)) (value (cdr (cdr aexp)))))
    ((equal? (car (cdr aexp)) '-) (minus (value (car aexp)) (value (cdr (cdr aexp)))))
    ((equal? (car (cdr aexp)) '*) (mul (value (car aexp)) (value (cdr (cdr aexp)))))
    ((equal? (car (cdr aexp)) '/) (div (value (car aexp)) (value (cdr (cdr aexp)))))
    ((equal? (car (cdr aexp)) '^) (expt (value (car aexp)) (car (cdr (cdr aexp)))))
    (t (value (car aexp)))))

(defun sero? (l) (null? l))

(defun edd1 (n)
  (cons '() n))

(defun zub1 (n)
  (cdr n))

(defun pluz (m n)
  (cond
    ((sero? n) m)
    (t (pluz (edd1 m) (zub1 n)))))
