;;; Chapter 18
(in-package :schemer-series)

(alias kar car)
(alias kdr cdr)
(alias konsC consC)
(alias kons cons)

(defvar kounter 0)

(defun lots (m)
  (cond
    ((zero? m) '())
    (t (kons 'egg (lots (sub1 m))))))

(defun lenkth (l)
  (cond
    ((null? l) 0)
    (t (add1 (lenkth (kdr l))))))

(defun add-at-end (l)
  (let ((konsC #'consC))
   (cond
     ((null? (kdr l)) (funcall konsC (kar l) '(egg)))
     (t (funcall konsC (kar l) (add-at-end (kdr l)))))))

(defun add-at-end-too (l)
  (labels ((A (ls)
	     (cond
	       ((null? (kdr ls)) (rplacd ls (kons 'egg '())))
	       (t (A (kdr ls))))))
    (A l)
    ;; We gotta return the input list as that has been mutated
    l))

;; (defun kar (c)
;;   (funcall c (lambda (s a d)
;; 	       (declare (ignore s))
;; 	       (declare (ignore d))
;; 	       a)))

;; (defun kdr (c)
;;   (funcall c (lambda (s a d)
;; 	       (declare (ignore s))
;; 	       (declare (ignore a))
;; 	       d)))

;; (defun bons (kar)
;;   (let ((kdr '()))
;;     (lambda (selector)
;;       (funcall selector (lambda (x) (setq kdr x))
;; 	       kar
;; 	       kdr))))

;; (defun set-kdr (c x)
;;   (funcall (funcall c (lambda (s a d)
;; 		(declare (ignore a))
;; 		(declare (ignore d))
;; 		s))
;;    x))

;; (defun kons (kar kdr)
;;   (let ((c (bons kar)))
;;     (set-kdr c kdr)
;;     c))

(defun dozen ()
  (lots 12))

(defun bakers-dozen ()
  (add-at-end (dozen)))

(defun bakers-dozen-too ()
  (add-at-end-too (dozen)))

(defun eklist? (ls1 ls2)
  (cond
    ((null? ls1) (null? ls2))
    ((null? ls2) nil)
    (t
     (and (eq? (kar ls1) (kar ls2))
	  (eklist? (kdr ls1) (kdr ls2))))))

(defun same? (c1 c2)
  (let ((t1 (kdr c1))
	(t2 (kdr c2)))
    (set-kdr c1 1)
    (set-kdr c2 2)
    (let ((v (= (kdr c1)
		(kdr c2))))
      (set-kdr c1 t1)
      (set-kdr c2 t2)
      v)))

(defun last-kons (ls)
  (cond
    ((null? (kdr ls)) ls)
    (t (last-kons (kdr ls)))))


(defun finite-lenkth (p)
  (catch 'infinite
    (labels ((C (p q)
	       (cond
		 ((same? p q) (throw 'infinite nil))
		 ((null? q) 0)
		 ((null? (kdr q)) 1)
		 (t (plus (C (sl p) (qk q))
			  2))))
	     (sl (x) (kdr x))
	     (qk (x) (kdr (kdr x))))
      (cond
	((null? p) 0)
	(t (add1 (C p (kdr p))))))))
