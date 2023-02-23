;;; Chapter 2
(in-package :schemer-series)

(defun member? (e lat)
  (cond
    ((null? lat) lat)
    ((equal? e (car lat)) t)
    (t (member? e (cdr lat)))))

(defun lat? (l)
  (cond
    ((null? l) t)
    ((atom? (car l)) (lat? (cdr l)))
    (t nil)))
