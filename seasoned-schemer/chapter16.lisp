;;; Chapter 16
(in-package :schemer-series)

(defun sweet-tooth (food)
  (cons food (cons 'cake '())))

(defun sweet-toothL (food)
  (let ((last 'angelfood))
    (setq last food)
    (cons food (cons 'cake '()))))

(defun sweet-toothR (food)
  (let ((ingredients '()))
    (setq ingredients (cons food ingredients))
    (cons food (cons 'cake '()))))


(defun deep (m)
  (cond
    ((zero? m) 'pizza)
    (t (cons (deep (sub1 m)) '()))))

(defvar Ns '())
(defvar Rs '())

(defun deepR (m &optional type)
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
