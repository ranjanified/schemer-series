;;; Chapter 19
(in-package :schemer-series)

(defvar toppings '())

(defun deepB (m)
  (cond
    ((zero? m)
     (catch 'jump
       (setq toppings 'jump)
       'pizza))
    (t (cons (deepB (sub1 m)) '()))))

(defun deep&Co (m k)
  (cond
    ((zero? m) (funcall k 'pizza))
    (t
     (deep&Co (sub1 m) (lambda (x) (funcall k (cons x '())))))))

(defun deep&CoB (m k)
  (cond
    ((zero? m)
     (let ()
       (setq toppings k)
       (funcall k 'pizza)))
    (t
     (deep&CoB (sub1 m) (lambda (x) (funcall k (cons x '())))))))

(defvar leave '())

(defun walk (l)
  (cond
    ((null? l) '())
    ((atom? (car l)) (throw leave (car l)))
    (t
     (let ()
       (walk (car l))
       (walk (cdr l))))))

(defun start-it (l)
  (catch 'here
    (setq leave 'here)
    (walk l)))

(defvar fill-1 '())

(defun rest1 (x)
  (waddle x))

(defun waddle (l)
  (cond
    ((null? l) '())
    ((atom? (car l))
     (let ()
       (catch 'rest
	 (setq fill-1 'rest)
	 (throw leave (car l)))
       (waddle (cdr l))))
    (t
     (let ()
       (waddle (car l))
       (waddle (cdr l))))))

(defun start-it2 (l)
  (catch 'here
    (setq leave 'here)
    (waddle l)))

(defun get-next (x)
  (catch 'here-again
    (setq leave 'here-again)
    (funcall fill-1 'go)))

(defun get-first (l)
  (catch 'here
    (setq leave 'here)
    (waddle l)
    (throw leave '())))

(defun two-in-a-row*? (l)
  (labels ((T? (a)
	     (let ((n (get-next 0)))
	       (if (atom? n)
		   (or (eq? n a) (T? n))
		   nil)))
	   (get-next (x)
	     (catch 'here-again
	       (setq leave 'here-again)
	       (fill-1 'go)))
	   (fill-1 (x) x)
	   (waddle (l)
	     (cond
	       ((null? l) '())
	       ((atom? (car l))
		(let ()
		  (catch 'rest
		    (setq fill-1 'rest)
		    (throw leave (car l)))
		  (waddle (cdr l))))
	       (t
		(let ()
		  (waddle (car l))
		  (waddle (cdr l))))))
	   (leave (x) x))
    (let ((fst (catch 'here
		 (setq leave 'here)
		 (waddle l)
		 (throw leave '()))))
      (if (atom? fst) (T? fst) nil))))
