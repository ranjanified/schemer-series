(in-package :schemer-series/tests)

(def-suite chapter1 :in the-little-schemer)
(in-suite chapter1)

(test atom?
  (is-true (atom? 'atom))
  (is-true (atom? 'turkey))
  (is-true (atom? 1492))
  (is-true (atom? 'u))
  (is-true (atom? '*abc$))
  (is-false (atom? '()))
  (is-true (let ((l '(swing low sweet cherry oat)))(atom? (car (cdr l)))))
  (is-false (let ((l '(Harry)))(atom? (cdr l))))
  (is-false (let ((l '(Harry had a heap of apples)))(atom? (cdr l))))
  (is-true (let ((l '(Harry had a heap of apples)))(atom? (car l))))
  (is-false (let ((s '(Harry had a heap of apples)))(atom? s)))
  (is-true (let ((s 'Harry))(atom? s)))
  (is-true (let ((n 14)) (atom? n)))
  (is-false (let ((l ' (((tomato sauce))
			((bean) sauce)
			(and ((flying)) sauce))))
	      (atom? (car l)))))

(test list?
  (is-true (list? '(atom)))
  (is-true (list? '(atom turkey or)))
  (is-true (list? '((atom tukey) or)))
  (is-true (list? '(how are you doing so far)))
  (is-true (list? '(((how are) ((you)) (doing so) far))))
  (is-true (list? '()))
  (is-true (list? '(() () () ()))))

(test sexp?
  (is-true (sexp? '((x y) z)))
      (is-true (sexp? '(x y z))))

(test car
  (is (equal? (let ((l '(a b c)))(car l))
	      'a))
  (is (equal? (let ((l '((a b c) x y z)))(car l))
	      '(a b c)))
  (is-false (car '()))
  (is (equal? (let ((l '(((hotdogs))(and)(pickle) relish)))(car l))
	      '((hotdogs)))))

(test caar
  (is (equal? (let ((l '(((hotdogs)) (and)))) (car (car l)))
	      '(hotdogs))))

(test cdr
  (is (equal? (let ((l '(a b c))) (cdr l))
	      '(b c)))
  (is (equal? (let ((l '((a b c) x y z))) (cdr l))
	      '(x y z)))
  (is (equal? (let ((l '((x) t r))) (cdr l))
	      '(t r)))
  (is (equal? (let ((l '(hamburger))) (cdr l))
	      '())))

(test cadr
  (is (equal? (let ((l '((b) (x y) ((c))))) (car (cdr l)))
	      '(x y))))

(test cddr
  (is (equal? (let ((l '((b) (x y) ((c))))) (cdr (cdr l)))
	      '(((c))))))

(test cons
  (is (equal? (let ((a 'peanut) (l '(butter and jelly))) (cons a l)) '(peanut butter and jelly)))
  (is (equal? (let ((s 'a) (l '((b) c d))) (cons s (cdr l))) '(a c d)))
  (is (equal? (let ((s 'a) (l '((b) c d))) (cons s l)) '(a (b) c d)))
  (is (equal? (let ((s 'a) (l 'b)) (cons s l)) '(a . b)))
  (is (equal? (let ((s '((a b c))) (l 'b)) (cons s l)) '(((a b c)) . b)))
  (is (equal? (let ((s 'a) (l '())) (cons s l)) '(a)))
  (is (equal? (let ((s '(a b (c))) (l '())) (cons s l)) '((a b (c)))))
  (is (equal? (let ((s '((help) this)) (l '(is very ((hard) to learn)))) (cons s l))
	      '(((help) this) is very ((hard) to learn)))))

(test null?
  (is-false (let ((a 'spaghetti)) (null? a)))
  (is-false (let ((l '(a b c))) (null? l)))
  (is-true (null? (quote ())))
  (is-true (let ((l '())) (null? l))))

(test eq?
  (is-true (let ((l '(beans beans we need jelly beans)))(eq? (car l) (car (cdr l)))))
  (is-false (let ((l '(soured milk)) (a 'milk))(eq? (cdr l) a)))
  (is-true (let ((l '(Mary Had A Little Lamb)) (a 'Mary))(eq? (car l) a)))
  (is-false (let ((n1 6) (n2 7))(eq? n1 n2)))
  (is-false (let ((l1 '()) (l2 '(strawberry)))(eq? l1 l2)))
  (is-false (let ((a1 'butter) (a2 'margarine))(eq? a1 a2)))
  (is-true (let ((a1 'Harry) (a2 'Harry))(eq? a1 a2))))

(test length
  (is (= (length '(how are you doing so far)) 6)))
