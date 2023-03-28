;;; Chapter 20
(in-package :schemer-series)

(defvar abort-1 (lambda (x) x))

(defun the-empty-table (name)
  (funcall abort-1
	   (cons 'no-answer (cons name '()))))

(defvar global-table (the-empty-table 'soma))

(defun lookup (table name)
  (funcall table name))

(defun extend (name1 value table)
  (lambda (name2)
    (cond
      ((eq? name2 name1) value)
      (t (funcall table name2)))))

(defun define? (e)
  (cond
    ((atom? e) nil)
    ((atom? (car e))
     (eq? (car e) 'define))
    (t nil)))

;; (defun value (e)
;;   (cond
;;     ((define? e) (*define e))
;;     (t (the-meaning e))))

(defun box (it)
  (lambda (sel)
    (funcall sel it (lambda (new) (setq it new)))))

(defun setbox (box new)
  (funcall box (lambda (it set) (declare (ignore it)) (funcall set new))))

(defun *define (e)
  (setq global-table
	(extend
	 (name-of e)
	 (box (the-meaning (right-side-of e)))
	 global-table)))

(defun unbox (box)
  (funcall box (lambda (it set) (declare (ignore set)) it)))

(defun the-meaning (e)
  (meaning e lookup-in-global-table))

(defun lookup-in-global-table (name)
  (lookup global-table name))

(defun meaning (e table)
  (funcall (expression-to-action e)
	   e table))

(defun *quote (e table)
  (declare (ignore table))
  (text-of e))

(defun *identifier (e table)
  (unbox (lookup table e)))

(defun *set (e table)
  (setbox
   (lookup table (name-of e))
   (meaning (right-side-of e) table)))

(defun *lambda (e table)
  (lambda (args)
    (beglis (body-of e)
	    (multi-extend (formals-of e)
			  (box-all args)
			  table))))

(defun beglis (es table)
  (cond
    ((null? (cdr es)) (meaning (car es) table))
    (t (funcall (lambda (val)
		  (declare (ignore val))
		  (beglis (cdr es) table)) (meaning (car es) table)))))

(defun box-all (vals)
  (cond
    ((null? vals) '())
    (t (cons (box (car vals))
	     (box-all (cdr vals))))))

(defun multi-extend (names values table)
  (cond
    ((null? names) table)
    (t
     (extend (car names) (car values)
	     (multi-extend (cdr names)
			   (cdr values)
			   table)))))

(defun odd? (n)
  (cond
    ((zero? n) nil)
    (t (even? (sub1 n)))))

(defun even? (n)
  (cond
    ((zero? n) t)
    (t (odd? (sub1 n)))))

(defun evlis (args table)
  (cond
    ((null? args) '())
    (t (funcall (lambda (val)
		  (cons val (evlis (cdr args) table)))
		(meaning (car args) table)))))

(defun *application (e table)
  (funcall (meaning (function-of e) table)
   (evlis (arguments-of e) table)))

(defun :car (args-in-a-list)
  (car (car args-in-a-list)))

(defun a-prim (p)
  (lambda (args-in-a-list)
    (funcall p (car args-in-a-list))))

(defun b-prim (p)
  (lambda (args-in-a-list)
    (funcall p
	     (car args-in-a-list)
	     (car (cdr args-in-a-list)))))

(defun *const (e table)
  (declare (ignore table))
  (let ((cons-1 (b-prim #'cons))
	(car-1 (a-prim #'car))
	(cdr-1 (a-prim #'cdr))
	(null? (a-prim #'null?))
	(eq? (b-prim #'eq?))
	(atom? (a-prim #'atom?))
	(number? (a-prim #'number?))
	(zero? (a-prim #'zero?))
	(add1 (a-prim #'add1))
	(sub1 (a-prim #'sub1)))
    (cond
      ((number? e) e)
      ((eq? e t) t)
      ((eq? e nil) nil)
      ((eq? e 'cons) cons-1)
      ((eq? e 'car) car-1)
      ((eq? e 'cdr) cdr-1)
      ((eq? e 'null?) null?)
      ((eq? e 'eq?) eq?)
      ((eq? e 'atom?) atom?)
      ((eq? e 'zero?) zero?)
      ((eq? e 'add1) add1)
      ((eq? e 'sub1) sub1)
      ((eq? e 'number?) number?))))

(defun evcon (lines table)
  (cond
    ((else? (question-of (car lines)))
     (meaning (answer-of (car lines)) table))
    ((meaning (question-of (car lines)) table)
     (meaning (answer-of (car lines)) table))
    (t (evcon (cdr lines) table))))

(defun *cond (e table)
  (evcon (cond-lines-of e) table))

(defun *letcc (e table)
  (catch 'skip
    (beglis (ccbody-of e)
	    (extend
	     (name-of e)
	     (box (a-prim 'skip))
	     table))))

(defun value (e)
  (catch 'the-end
    (setq abort-1 'the-end)
    (cond
      ((define? e) (*define e))
      (t (the-meaning e)))))

(defun expression-to-action (e)
  (cond
    ((number? e) #'*const)
    ((eq? e t) #'*const)
    ((eq? e nil) #'*const)
    ((eq? e 'cons) #'*const)
    ((eq? e 'car) #'*const)
    ((eq? e 'cdr) #'*const)
    ((eq? e 'null?) #'*const)
    ((eq? e 'eq?) #'*const)
    ((eq? e 'atom?) #'*const)
    ((eq? e 'zero?) #'*const)
    ((eq? e 'add1) #'*const)
    ((eq? e 'sub1) #'*const)
    ((eq? e 'number?) #'*const)
    (t #'*identifier)))

(defun list-to-application (e)
  (cond
    ((atom? (car e))
     (cond
       ((eq? (car e) 'quote) #'*quote)
       ((eq? (car e) 'lambda) #'*lambda)
       ((eq? (car e) 'letcc) #'*letcc)
       ((eq? (car e) 'setq) #'*set)
       ((eq? (car e) 'cond) #'*cond)
       (t #'*application)))
    (t #'*application)))

(defun text-of (x)
  (car (cdr x)))

(defun formals-of (x)
  (car (cdr x)))

(defun body-of (x)
  (cdr (cdr x)))

(defun ccbody-of (x)
  (cdr (cdr x)))

(defun name-of (x)
  (car (cdr x)))

(defun right-side-of (x)
  (cond
    ((null? (cdr (cdr x))) 0)
    (t (car (cdr (cdr x))))))

(defun cond-lines-of (x)
  (cdr x))

(defun else? (x)
  (cond
    ((atom? x) (eq? x 'else))
    (t nil)))

(defun question-of (x)
  (car x))

(defun answer-of (x)
  (car (cdr x)))

(defun function-of (x)
  (car x))

(defun arguments-of (x)
  (cdr x))
