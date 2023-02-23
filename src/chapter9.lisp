(in-package :schemer-series)

(defun keep-looking (a n lat)
  (cond
    ((number? n) (keep-looking a (pick n lat) lat))
    (t (eq? a n))))

(defun looking (a lat)
  (keep-looking a 1 lat))

(defun eternity (x)
  (eternity x))

(defun shift (x)
  (build (first (first-l x))
	 (build (second-l (first x))
		(second-l x))))

(defun align (pora)
  (cond
    ((atom? pora) pora)
    ((a-pair? (first-l pora))
     (align (shift pora)))
    (t (build (first-l pora)
	      (align (second-l pora))))))

(defun length* (pora)
  (cond
    ((atom? pora) 1)
    (t (plus (length* (first-l pora))
	     (length* (second-l pora))))))

(defun weight* (pora)
  (cond
    ((atom? pora) 1)
    (t (plus (mul (weight* (first-l pora)) 2)
	     (weight* (second-l pora))))))

(defun shuffle (pora)
  (cond
    ((atom? pora) pora)
    ((a-pair? (first-l pora)) (shuffle (revpair pora)))
    (t (build (first-l pora)
	      (shuffle (second-l pora))))))


(defun will-stop? (f)
  (and (funcall f '()) t))

(defun length0 (l)
  (cond
    ((null? l) 0)
    (t (add1 (eternity (cdr l))))))



(defun length1 (l)
  (cond
    ((null? l) 0)
    (t (add1
	((lambda (l)
	   (cond
	     ((null? l) 0)
	     (t (add1 (eternity (cdr l))))))
	 (cdr l))))))

(defun length2 (l)
  (cond
    ((null? l) 0)
    (t (add1
	((lambda (l)
	   (cond
	     ((null? l) 0)
	     (t (add1
		 ((lambda (l)
		    (cond
		      ((null? l) 0)
		      (t (add1 (eternity (cdr l))))))
		  (cdr l))))))
	 (cdr l))))))

;; length
;; ((lambda (mk-length)
;;    (mk-length mk-length))
;;  (lambda (mk-length)
;;    (lambda (l)
;;      (cond
;;        ((null? l) 0)
;;        (t (add1 ((mk-length eternity) (cdr l))))))))

;; (let ((x '(apples)))
;;   (funcall ((lambda (mk-length)
;;       (funcall mk-length mk-length))
;;     (lambda (mk-length)
;;       (lambda (l)
;; 	(cond
;; 	  ((schemer-series:null? l) 0)
;; 	  (t (1+ (funcall (funcall mk-length #'schemer-series::eternity)
;; 		  (cdr l))))))))
;;    x))

;; https://mvanier.livejournal.com/2897.html <==== Gotta Check

(defun Y (le)
  (funcall ((lambda (f) (funcall f f))
    (lambda (f)
      (funcall le (lambda (x) (funcall (funcall f f) x)))))))
