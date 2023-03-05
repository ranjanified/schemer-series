;;; Chapter 17
(in-package :schemer-series)

(defun deep-M (n)
  (labels ((D (m)
	     (if (zero? m) 'pizza
		 (cons (deep-M (sub1 m)) '()))))
    (let ((exists (let () (find-l n Ns Rs))))
      (if (null? exists)
	  (let ((result (D n)))
	    (setq Ns (cons n Ns))
	    (setq Rs (cons result Rs))
	    result)
	  exists))))

(defvar *counter* 0)

(defun consC (x y)
  (setq *counter* (add1 *counter*))
  (cons x y))

(defun deep-C (m)
  (if (zero? m) 'pizza
      (consC (deep-C (sub1 m)) '())))

(defun supercounter (f)
  (labels ((S (n)
	     (if (zero? n)
		 (funcall f n)
		 (let ((m (sub1 n)))
		   (funcall f n)
		   (S m)
		   *counter*))))
    (S 1000)))

(defun rember1*C (a l)
  (labels ((R (l oh)
	     (cond
	       ((null? l) (throw oh 'no))
	       ((atom? (car l))
		(if (eq? (car l) a)
		    (cdr l)
		    (consC (car l) (R (cdr l) oh))))
	       (t
		(let ((new-car (catch oh (R (car l) oh))))
		  (if (atom? new-car)
		      (consC (car l) (R (cdr l) oh))
		      (consC new-car (cdr l))))))))
    (let ((new-l (catch 'oh (R l 'oh))))
      (if (atom? new-l)
	  l
	  new-l))))

(defun rember1*C2 (a l)
  (labels ((R (l)
	     (cond
	       ((null? l) '())
	       ((atom? (car l))
		(if (eq? (car l) a)
		    (cdr l)
		    (consC (car l) (R (cdr l)))))
	       (t
		(let ((av (R (car l))))
		  (if (eqlist? (car l) av)
		      (consC (car l) (R (cdr l)))
		      (consC av (cdr l))))))))
    (R l)))
