;;; Chapter 4
(in-package :schemer-series)

(defun no-nums (lats)
  (cond
    ((null? lats) lats)
    ((number? (car lats)) (no-nums (cdr lats)))
    (t (cons (car lats) (no-nums (cdr lats))))))

(defun all-nums (lats)
  (cond
    ((null? lats) lats)
    ((number? (car lats)) (cons (car lats) (all-nums (cdr lats))))
    (t (all-nums (cdr lats)))))

(defun equan? (a1 a2)
  (cond
    ((and (number? a1) (number? a2)) (= a1 a2))
    (t (eq? a1 a2))))

(defun tup? (lonums)
  (cond
    ((null? lonums) t)
    (t (and (number? (car lonums)) (tup? (cdr lonums))))))

(defun sub1 (n) (1- n))

(defun add1 (n) (1+ n))

(defun occur (a lat)
  (cond
    ((null? lat) 0)
    ((eq? a (car lat)) (add1 (occur a (cdr lat))))
    (t (occur a (cdr lat)))))

(defun one? (a)
  (cond
    ((zero? a) nil)
    (t (zero? (sub1 a)))))

(defun greater (m n)
  (cond
    ((zero? m) nil)
    ((zero? n) t)
    (t (greater (sub1 m) (sub1 n)))))

(defun lesser (m n)
  (cond
    ((zero? n) nil)
    ((zero? m) t)
    (t (lesser (sub1 m) (sub1 n)))))

(defun pick (n lat)
  (cond
    ((lesser n 1) nil)
    ((zero? (sub1 n)) (car lat))
    (t (pick (sub1 n) (cdr lat)))))

(defun rempick (n lat)
  (cond
    ((zero? (sub1 n)) (cdr lat))
    (t (cons (car lat) (rempick (sub1 n) (cdr lat))))))

(defun tup+ (tup1 tup2)
  (cond
    ((null? tup1) tup2)
    ((null? tup2) tup1)
    (t (cons (plus (or (car tup1) 0) (or (car tup2) 0))
	     (tup+ (cdr tup1) (cdr tup2))))))

(defun addtup (lonums)
  (cond
    ((null? lonums) 0)
    ((number? (car lonums)) (plus (car lonums) (addtup (cdr lonums))))
    (t (addtup (cdr lonums)))))

(defun plus (a b)
  (cond
    ((zero? b) a)
    (t (plus (add1 a) (sub1 b)))))

(defun minus (a b)
  (cond
    ((zero? b) a)
    (t (minus (sub1 a) (sub1 b)))))

(defun mul (n m)
  (cond
    ((zero? m) 0)
    (t (plus n (mul n (sub1 m))))))

(defun div (m n)
  (cond
    ((lesser m n) 0)
    (t (add1 (div (minus m n) n)))))

(defun lat-length (lat)
  (cond
    ((null? lat) 0)
    (t (add1 (lat-length (cdr lat))))))
