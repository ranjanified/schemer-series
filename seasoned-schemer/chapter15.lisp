;;; Chapter 15
(in-package :schemer-series)

(defvar x (cons 'chicago (cons 'pizza '())))
(setq x 'gone)
(setq x 'skins)

(defun gourmet (food)
  (cons food (cons x '())))

(defun gourmand (food)
  (let ((x '()))
    (setq x food)
    (cons food (cons x '()))))

(defun diner (food)
  (cons 'milkshake (cons food '())))

(defun dinerR (food)
  (let ((x '()))
    (setq x
	  food)
    (diner food)))

(defun omnivore (food)
  (let ((x 'minestrone))
    (setq x food)
    (cons food (cons x '()))))

(defun gobbler (food)
  (let ((x 'minestrone))
    (setq x food)
    (cons food (cons x '()))))

(defun nibbler (food)
  (let ((x 'donut))
    (setq x food)
    (cons food (cons x '()))))

(defun glutton (food)
  (let ((x 'none))
    (setq x food)
    (cons 'more (cons food (cons 'more (cons food '()))))))
