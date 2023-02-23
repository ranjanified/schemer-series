;;; Chapter 5
(in-package :schemer-series)

(defun rember* (a l)
  (cond
    ((null? l) l)
    ((atom? (car l)) (cond
	  ((equal? a (car l)) (rember* a (cdr l)))
	  (t (cons (car l) (rember* a (cdr l))))))
    (t (cons (rember* a (car l)) (rember* a (cdr l))))))

(defun insertL* (new old l)
  (cond
    ((null? l) l)
    ((atom? (car l))
     (if (equal? (car l) old)
	 (cons new (cons old (insertL* new old (cdr l))))
	 (cons (car l) (insertL* new old (cdr l)))))
    (t (cons (insertL* new old (car l)) (insertL* new old (cdr l))))))

(defun insertR* (new old lat)
  (cond
    ((null? lat) lat)
    ((atom? (car lat))
     (cond
       ((equal? (car lat) old) (cons old (cons new (insertR* new old (cdr lat)))))
       (t (cons (car lat) (insertR* new old (cdr lat))))))
    (t (cons (insertR* new old (car lat)) (insertR* new old (cdr lat))))))

(defun occur* (a l)
  (cond
    ((null? l) 0)
    ((atom? (car l))
     (if
      (equal? (car l) a)
      (add1 (occur* a (cdr l)))
      (occur* a (cdr l)) ))
    (t (plus (occur* a (car l)) (occur* a (cdr l))))))

(defun subst* (new old l)
  (cond
    ((null? l) l)
    ((atom? (car l))
     (if (equal? (car l) old)
	 (cons new (subst* new old (cdr l)))
	 (cons (car l) (subst* new old (cdr l)))))
    (t (cons (subst* new old (car l)) (subst* new old (cdr l))))))

(defun member* (a l)
  (cond
    ((null? l) nil)
    ((atom? (car l)) (or (equal? (car l) a) (member* a (cdr l))))
    (t (or (member* a (car l)) (member* a (cdr l))))))

(defun leftmost (l)
  (cond
    ((null? l) nil)
    ((atom? (car l)) (car l))
    (t (leftmost (car l)))))

(defun eqlist? (l1 l2)
  (cond
    ((null? l1) (null? l2))
    ((and (atom? l1) (atom? l2)) (equal? l1 l2))
    ((or (atom? l2) (atom? l1)) nil)
    (t (and (eqlist? (car l1) (car l2)) (eqlist? (cdr l1) (cdr l2))))))
