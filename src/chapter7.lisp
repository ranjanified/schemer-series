(in-package :schemer-series)

(defun set? (lat)
  (cond
    ((null? lat) t)
    ((member? (car lat) (cdr lat)) nil)
    (t (set? (cdr lat)))))

(defun makeset (lat)
  (cond
    ((null? lat) lat)
    ((member? (car lat) (cdr lat)) (makeset (cdr lat)))
    (t (cons (car lat) (makeset (cdr lat))))))

(defun subset? (set1 set2)
  (cond
    ((null? set1) t)
    ((member? (car set1) set2) (subset? (cdr set1) set2))
    (t nil)))

(defun eqset? (set1 set2)
  (and (subset? set1 set2) (subset? set2 set1)))

(defun intersect? (set1 set2)
  (cond
    ((null? set1) nil)
    ((member? (car set1) set2) t)
    (t (intersect? (cdr set1) set2))))

(defun intersect (set1 set2)
  (cond
    ((null? set1) '())
    ((member? (car set1) set2) (cons (car set1) (intersect (cdr set1) set2)))
    (t (intersect (cdr set1) set2))))

(defun union-1 (set1 set2)
  (cond
    ((null? set1) set2)
    ((member? (car set1) set2) (union-1 (cdr set1) set2))
    (t (cons (car set1) (union-1 (cdr set1) set2)))))

(defun set-diff (set1 set2)
  (cond
    ((null? set1) '())
    ((member? (car set1) set2) (set-diff (cdr set1) set2))
    (t (cons (car set1) (set-diff (cdr set1) set2)))))

(defun intersectall (l-set)
  (cond
    ((null? (cdr l-set)) (car l-set))
    (t (intersect (car l-set) (intersectall (cdr l-set))))))

(defun a-pair? (l)
  (cond
    ((atom? l) nil)
    ((null? l) nil)
    ((null? (cdr l)) nil)
    ((null? (cdr (cdr l))) t)
    (t nil)))

(defun first-l (l)
  (cond
    (t (car l))))

(defun second-l (l)
  (cond
    (t (car (cdr l)))))

(defun third-l (l)
  (cond
    (t (car (cdr (cdr l))))))

(defun build (l1 l2)
  (cons l1 (cons l2 '())))

(defun revpair (pair)
  (build (second-l pair) (first-l pair)))

(defun rel (l)
  (cond
    ((null? l) t)
    (t (and (a-pair? (car l)) (rel (cdr l))))))

(defun fun? (l) (set? (firsts l)))

(defun revrel (l)
  (cond
    ((null? l) '())
    (t (cons (build (second-l (car l))
		    (first-l (car l)))
	     (revrel (cdr l))))))

(defun fullfun? (fun) (set? (seconds fun)))
