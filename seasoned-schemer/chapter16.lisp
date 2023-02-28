;;; Chapter 16
(in-package :schemer-series)

(defvar last-s 'angelfood)
(defvar ingredients '())
(defvar Ns '())
(defvar Rs '())

(defun sweet-tooth (food)
  (cons food (cons 'cake '())))

(defun sweet-toothL (food)
  (setq last-s food)
  (cons food (cons 'cake '())))

(defun sweet-toothR (food)
  (setq ingredients (cons food ingredients))
  (cons food (cons 'cake '())))


(defun deep (m)
  (cond
    ((zero? m) 'pizza)
    (t (cons (deep (sub1 m)) '()))))

(defun deepR (m)
  (let ((R (deep m)))
    (setq Ns (cons m Ns))
    (setq Rs (cons R Rs))
    R))

(defun find-l (n ns rs)
  (labels ((A (ns rs)
	     (cond
	       ((null? ns) '())
	       ((= (car ns) n) (car rs))
	       (t (A (cdr ns) (cdr rs))))))
    (A ns rs)))

(defun deepM (n)
  (if (member-? n Ns)
      (find-l n Ns Rs)
      (let ((result (deep n)))
	(setq Ns (cons n Ns))
	(setq Rs (cons result Rs))
	result)))

(defun L (length)
  (lambda (l)
    (cond
      ((null? l) 0)
      (t (add1 (funcall length (cdr l)))))))

(defun Y! (L)
  (let ((h (lambda (_) '())))
    (setq h (funcall L (lambda (arg) (funcall h arg))))
    h))

(defvar l-length
  (let ((h (lambda (_) 0)))
    (setq h (L (lambda (arg) (funcall h arg))))
    h))

(defvar ll-length (Y! #'L))
