(in-package :schemer-series)

(defun rember-f (test? a l)
  (cond
    ((null? l) l)
    ((funcall test? (car l) a) (rember-f test? a (cdr l)))
    (t (cons (car l) (rember-f test? a (cdr l))))))

(defun eq?-c (a)
  (lambda (x) (eq? x a)))

(defun seqL (new old l)
  (cons new (cons old l)))

(defun seqR (new old l)
  (cons old (cons new l)))

(defun seqS (new old l)
  (declare (ignore old))
  (cons new l))

(defun insert-g (test? seq)
  (lambda (new old l)
    (cond
      ((null? l) l)
      ((funcall test? old (car l)) (funcall seq new old (cdr l)))
      (t (cons (car l) (funcall (insert-g test? seq) new old (cdr l)))))))

(defun insertL-f (test?)
  (insert-g test? #'seqL))

(defun insertR-f (test?)
  (insert-g test? #'seqR))

(defun insertS-f (test?)
  (insert-g test? #'seqS))

(defun seqrem (new old l)
  (declare (ignore new) (ignore old))
  l)

(defun yyy (a l)
  (funcall (insert-g #'equal?  #'seqrem) nil a l))

(defun multirember-f (test?)
  (lambda (a lat)
    (cond
      ((null? lat) lat)
      ((funcall test? (car lat) a) (funcall (multirember-f test?) a (cdr lat)))
      (t (cons (car lat) (funcall (multirember-f test?) a (cdr lat)))))))

(defun multirember-eq? () (multirember-f #'eq?))

(defun multiremberT (test? lat)
  (cond
    ((null? lat) lat)
    ((funcall test? (car lat)) (multiremberT test? (cdr lat)))
    (t (cons (car lat) (multiremberT test? (cdr lat))))))

(defun multirember&Co (a lat col)
  (cond
    ((null? lat) (funcall col '() '()))
    ((eq? (car lat) a) (multirember&Co a (cdr lat)
				       (lambda (newlat seen) ;; This is beautiful... Iteration over Recursion
					 (funcall col newlat (cons (car lat) seen)))))
    (t (multirember&co a (cdr lat)
		       (lambda (newlat seen)
			 (funcall col (cons (car lat) newlat) seen))))))

(defun multiinsertLR (new oldL oldR lat)
  (cond
    ((null? lat) lat)
    ((equal? (car lat) oldL) (cons new (cons oldL (multiinsertLR new oldL oldR (cdr lat)))))
    ((equal? (car lat) oldR) (cons oldR (cons new (multiinsertLR new oldL oldR (cdr lat)))))
    (t (cons (car lat) (multiinsertLR new oldL oldR (cdr lat))))))

(defun multiinsertLR&Co (new oldL oldR lat collector)
  (cond
    ((null? lat) (funcall collector '() 0 0))
    ((equal? (car lat) oldL) (multiinsertLR&Co new oldL oldR (cdr lat)
					       (lambda (newlat countL countR)
						 (funcall collector (cons new (cons oldL newlat)) (add1 countL) countR))))
    ((equal? (car lat) oldR) (multiinsertLR&Co new oldL oldR (cdr lat)
					       (lambda (newlat countL countR)
						 (funcall collector (cons oldR (cons new newlat)) countL (add1 countR)))))
    (t (multiinsertLR&Co new oldL oldR (cdr lat) (lambda (newlat countL countR)
						   (funcall collector (cons (car lat) newlat) countL countR))))))

(defun evens-only* (l)
  (cond
    ((null? l) l)
    ((atom? (car l))
     (cond
       ((even? (car l)) (cons (car l) (evens-only* (cdr l))))
       (t (evens-only* (cdr l)))))
    (t (cons (evens-only* (car l)) (evens-only* (cdr l))))))

(defun evens-only*&Co (l collector)
  (cond
    ((null? l) (funcall collector '() 1 0))
    ((atom? (car l))
     (cond
       ((even? (car l))
	(evens-only*&Co (cdr l)
			(lambda (evenslat mulEvens sumOdds)
			  (funcall collector (cons (car l) evensLat) (mul (car l) mulEvens) sumOdds))))
       (t (evens-only*&Co (cdr l)
			  (lambda (evenslat mulEvens sumOdds)
			    (funcall collector evensLat mulEvens (plus (car l) sumOdds)))))))
    (t (evens-only*&Co (car l)
		       (lambda (l-evenLats l-mulEvens l-sumOdds)
			 (evens-only*&Co (cdr l)
					 (lambda (evenLats mulEvens sumOdds)
					   (funcall collector
						    (append l-evenLats evenLats)
						    (mul l-mulEvens mulEvens)
						    (plus l-sumOdds sumOdds)))))))))
