(in-package :schemer-series)

(defmacro alias (to fn)
    `(setf (fdefinition ',to) #',fn))

;; (defconstant ^ (make-symbol "^"))
(defconstant \#t t)
(defconstant \#f nil)

(alias equal? equal)
(alias eq? eq)
(alias list? listp)
(alias null? null)
(alias atom? (lambda (x) (not (list? x))))
(alias sexp? (lambda (x) (or (list? x) (atom? x))))
(alias boolean? (lambda (v) (eql v \#t)))
(alias number? numberp)
(alias zero? zerop)
(alias even? evenp)



