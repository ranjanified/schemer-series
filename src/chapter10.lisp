(in-package :schemer-series)

(alias new-entry build)
(alias text-of second-l)
(alias table-of first-l)
(alias formals-of second-l)
(alias body-of third-l)
(alias question-of first-l)
(alias answer-of second-l)
(alias function-of car)
(alias arguments-of cdr)
(alias cond-lines-of cdr)

(defun lookup-in-entry-help (name names values entry-f)
  (cond
    ((null? names) (funcall entry-f name))
    ((eq? (car names) name) (car values))
    (t (lookup-in-entry-help name (cdr names) (cdr values) entry-f))))

(defun lookup-in-entry (name entry entry-f)
  (lookup-in-entry-help name
			(first-l entry)
			(second-l entry)
			entry-f))

(defun extend-table (entry table)
  (and (not (null? entry)) (cons entry table)))

(defun lookup-in-table (name table table-f)
  (cond
    ((null? table) (funcall table-f name))
    (t (lookup-in-entry name (car table)
			(lambda (n)
			  (declare (ignore n))
			  (lookup-in-table name (cdr table) table-f))))))

(defun expression-to-action (e)
  (cond
    ((atom? e) (atom-to-action e))
    (t (list-to-action e))))

(defun *const (e table)
  (declare (ignore table))
  (cond
    ((number? e) e)
    ((eq? e t) t)
    ((eq? e nil) nil)
    (t (build 'primitive e))))

(defun *quote (e table)
  (declare (ignore table))
  (text-of e))

(defconstant initial-table '())

(defun *identifier (e table)
  (lookup-in-table e table initial-table))

(defun *lambda (e table)
  (build 'non-primitive (cons table (cdr e))))

(defun *cond (e table)
  (evcon (cond-lines-of e) table))

(defun *application (e table)
  (apply-l (meaning (function-of e) table)
	 (evlis (arguments-of e) table)))

(defun atom-to-action (e)
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

(defun list-to-action (e)
  (cond
    ((atom? (car e))
     (cond
       ((eq? (car e) 'quote) #'*quote)
       ((eq? (car e) 'lambda) #'*lambda)
       ((eq? (car e) 'cond) #'*cond)
       (t #'*application)))
    (t #'*application)))

(defun value-e (e)
  (meaning e '()))

(defun meaning (e table)
  (funcall (expression-to-action e) e table))

(defun else? (x)
  (cond
    ((atom? x) (eq? x 'else))
    (t nil)))

(defun evcon (lines table)
  (cond
    ((else? (question-of (car lines))) (meaning (answer-of (car lines)) table))
    ((meaning (question-of (car lines)) table)
     (meaning (answer-of (car lines)) table))
    (t (evcon (cdr lines) table))))

(defun evlis (args table)
  (cond
    ((null? args) '())
    (t (cons (meaning (car args) table)
	     (evlis (cdr args) table)))))

(defun primitive? (l)
  (eq? (first-l l) 'primitive))

(defun non-primitive?  (l)
  (eq? (first-l l) 'non-primitive))

(defun apply-l (fun vals)
  (cond
    ((primitive? fun) (apply-primitive (second-l fun) vals))
    ((non-primitive? fun) (apply-closure (second-l fun) vals))))

(defun :atom? (x)
  (cond
    ((atom? x) t)
    ((null? x) nil)
    ((eq? (car x) 'primitive) t)
    ((eq? (car x) 'non-primitive) t)
    (t nil)))

(defun apply-primitive (name vals)
  (cond
    ((eq? name 'cons) (cons (first-l vals) (second-l vals)))
    ((eq? name 'car) (car (first-l vals)))
    ((eq? name 'cdr) (cdr (first-l vals)))
    ((eq? name 'null?) (null? (first-l vals)))
    ((eq? name 'eq?) (eq? (first-l vals) (second-l vals)))
    ((eq? name 'atom?) (:atom? (first-l vals)))
    ((eq? name 'zero?) (zero? (first-l vals)))
    ((eq? name 'add1) (add1 (first-l vals)))
    ((eq? name 'sub1) (sub1 (first-l vals)))
    ((eq? name 'number?) (number? (first-l vals)))))

(defun apply-closure (closure vals)
  (meaning (body-of closure)
	   (extend-table (new-entry (formals-of closure)
				    vals)
			 (table-of closure))))
