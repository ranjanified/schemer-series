(in-package :schemer-series/tests)

(def-suite chapter3 :in the-little-schemer)
(in-suite chapter3)

(test insertL
  (is (equal? (let ((old 'fudge) (new 'topping) (lat '(ice cream with fudge for dessert)))(insertL new old lat))
	      '(ice cream with topping fudge for dessert)))
  (is (equal? (let ((old 'and) (new 'jalapeno) (lat '(tacos tamales and salsa)))(insertL new old lat))
	      '(tacos tamales jalapeno and salsa)))
  (is (equal? (let ((old 'd) (new 'e) (lat '(a b c d f g d h)))(insertL new old lat))
	      '(a b c e d f g d h))))

(test insertR
  (is (equal? (let ((old 'fudge) (new 'topping) (lat '(ice cream with fudge for dessert)))(insertR new old lat))
	      '(ice cream with fudge topping for dessert)))
  (is (equal? (let ((old 'and) (new 'jalapeno) (lat '(tacos tamales and salsa)))(insertR new old lat))
	      '(tacos tamales and jalapeno salsa)))
  (is (equal? (let ((old 'd) (new 'e) (lat '(a b c d f g d h)))(insertR new old lat))
	      '(a b c d e f g d h))))

(test subst2
  (is (equal? (let ((new 'vanilla)
		    (old1 'chocolate)
		    (old2 'banana)
		    (lat '(vanilla ice cream with chocolate topping)))
		(subst2 new old1 old2 lat))
	      '(vanilla ice cream with vanilla topping))))

(test substi-tute
  (is (equal? (let ((old 'fudge) (new 'topping) (lat '(ice cream with fudge for dessert)))(substi-tute new old lat))
	      '(ice cream with topping for dessert))))

(test multisubst
  (is (equal? (let ((new 'some)
		    (old 'hand)
		    (lat '(A hand that hand some hand)))
		(multisubst new old lat))
	      '(A some that some some some))))

(test multi-insert-L
  (is (equal? (let ((new 'some)
		    (old 'hand)
		    (lat '(A hand that hand some hand)))
		(multi-insert-L new old lat))
	      '(A some hand that some hand some some hand))))

(test multi-insert-R
  (is (equal? (let ((new 'some)
		    (old 'hand)
		    (lat '(A hand that hand some hand)))
		(multi-insert-R new old lat))
	      '(A hand some that hand some some hand some))))

(test multirember
  (is (equal? (let ((a 'mint) (lat '(lamb chops and mint jelly)))(multirember a lat))
	      '(lamb chops and jelly)))
  (is (equal? (let ((a 'mint) (lat '(lamb chops and mint flavoured mint jelly)))(multirember a lat))
	      '(lamb chops and flavoured jelly)))
  (is (equal? (let ((a 'toast) (lat '(bacon lettuce and tomato)))(multirember a lat))
	      '(bacon lettuce and tomato)))
  (is (equal? (let ((a 'cup) (lat '(coffee cup tea cup and hick cup)))(multirember a lat))
	      '(coffee tea and hick))))

(test firsts
  (is (equal? (let ((lolats '((apple peach pumpkin)
			      (plum pear cherry)
			      (grape raisin pea)
			      (bean carrot eggplant))))
		(firsts lolats))
	      '(apple plum grape bean)))
  (is (equal? (let ((lolats '((a b) (c d) (e f))))(firsts lolats))
	      '(a c e)))
  (is (equal? (let ((lolats '(((five plums) four)
			      (eleven green oranges)
			      ((no) more))))
		(firsts lolats))
	      '((five plums) eleven (no)))))

(test seconds
  (is (equal? (let ((lolats '((a b) (c d) (e f))))
		(seconds lolats))
	      '(b d f))))

(test rember
  (is (equal? (let ((a 'mint) (lat '(lamb chops and mint jelly)))(rember a lat))
	      '(lamb chops and jelly)))
  (is (equal? (let ((a 'mint) (lat '(lamb chops and mint flavoured mint jelly)))(rember a lat))
	      '(lamb chops and flavoured mint jelly)))
  (is (equal? (let ((a 'toast) (lat '(bacon lettuce and tomato)))(rember a lat))
	      '(bacon lettuce and tomato)))
  (is (equal? (let ((a 'cup) (lat '(coffee cup tea cup and hick cup)))(rember a lat))
	      '(coffee tea cup and hick cup))))
