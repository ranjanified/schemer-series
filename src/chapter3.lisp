;;; Chapter 3
(in-package :schemer-series)

(defun multisubst (new old lat)
  (cond
    ((null? lat) lat)
    ((eq? old (car lat)) (cons new (multisubst new old (cdr lat))))
    (t (cons (car lat) (multisubst new old (cdr lat))))))

(defun multi-insert-L (new old lat)
  (cond
    ((null? lat) lat)
    ((eq? old (car lat)) (cons new (cons old (multi-insert-L new old (cdr lat)))))
    (t (cons (car lat) (multi-insert-L new old (cdr lat))))))

(defun multi-insert-R (new old lat)
  (cond
    ((null? lat) lat)
    ((eq? old (car lat)) (cons old (cons new (multi-insert-R new old (cdr lat)))))
    (t (cons (car lat) (multi-insert-R new old (cdr lat))))))

(defun multirember (a lat)
  (cond
    ((null? lat) lat)
    ((eq? a (car lat)) (multirember a (cdr lat)))
    (t (cons (car lat) (multirember a (cdr lat))))))

(defun subst2 (new old1 old2 lat)
  (cond
    ((null? lat) lat)
    ((or (eq? old1 (car lat))
	 (eq? old2 (car lat))) (cons new (cdr lat)))
    (t (cons (car lat) (subst2 new old1 old2 (cdr lat))))))

(defun substi-tute (new old lat)
  (cond
    ((null? lat) lat)
    ((eq? old (car lat)) (cons new (cdr lat)))
    (t (cons (car lat) (subst new old (cdr lat))))))

(defun insertL (new old lat)
  (cond
    ((null? lat) lat)
    ((eq? old (car lat)) (cons new lat))
    (t (cons (car lat) (insertL new old (cdr lat))))))

(defun insertR (new old lat)
  (cond
    ((null? lat) lat)
    ((eq? old (car lat)) (cons old (cons new (cdr lat))))
    (t (cons (car lat) (insertR new old (cdr lat))))))

(defun seconds (lolats)
  (cond
    ((null? lolats) '())
    (t (cons (cadar lolats) (seconds (cdr lolats))))))

(defun firsts (lolats)
  (cond
    ((null? lolats) '())
    (t (cons (caar lolats) (firsts (cdr lolats))))))

(defun rember (a lat)
  (cond
    ((null? lat) '())
    ((eq? a (car lat)) (cdr lat))
    (t (cons (car lat) (rember a (cdr lat))))))
