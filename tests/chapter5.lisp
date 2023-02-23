(in-package :schemer-series/tests)

(def-suite chapter5 :in the-little-schemer)
(in-suite chapter5)

(test rember*
  (is-true (equal? (rember* 3 '(3)) '()))
  (is-true (equal? (let ((a 'cup)
			 (l '((coffee) cup ((tea) cup)(and (hick)) cup)))
		     (rember* a l))
		   '((coffee) ((tea)) (and (hick))))))

(test insertL*
  (is (equal? (let ((old 'chuck) (new 'roast)
		    (lat '((how much (wood)) could
			   ((a (wood) chuck))
			   (((chuck)))
			   (if (a) ((wood chuck)))
			   could chuck wood) ))
		(insertL* new old lat))
	      '((how much (wood)) could
		((a (wood) roast chuck))
		(( (roast chuck)))
		(if (a) ((wood roast chuck)))
		could roast chuck wood)))
  (is (equal? (let ((old 'chuck) (new 'pecker)
		    (lat '((how much (wood)) could
			   ((a (wood) chuck))
			   (((chuck)))
			   (if (a) ((wood chuck)))
			   could chuck wood) ))
		(insertL* new old lat))
	      '((how much (wood)) could
		((a (wood) pecker chuck))
		(( (pecker chuck)))
		(if (a) ((wood pecker chuck)))
		could pecker chuck wood))))

(test insertR*
  (is (equal? (let ((old 'chuck) (new 'roast)
		    (lat '((how much (wood)) could
			   ((a (wood) chuck))
			   (((chuck)))
			   (if (a) ((wood chuck)))
			   could chuck wood) ))
		(insertR* new old lat))
	      '((how much (wood)) could
		((a (wood) chuck roast))
		(( (chuck roast)))
		(if (a) ((wood chuck roast)))
		could chuck roast wood))))

(test occur*
  (is (= (let ((a 'banana)
	       (l '((banana)
		    (split ((((banana ice)))
			    (cream (banana))
			    sherbet)) (banana) (bread)
		    (banana brandy))))
	   (occur* a l)))
      5))

(test subst*
  (is (equal? (let ((new 'orange) (old 'banana)
		    (l '((banana)(split ((((banana ice)))(cream (banana)) sherbet))(banana)(bread)(banana brandy))))
		(subst* new old l))
	      '((orange)(split ((((orange ice)))(cream (orange)) sherbet))(orange)(bread)(orange brandy)))))

(test member*
  (is-true (let ((a 'chips)
		 (l '((potato) (chips ((with) fish) (chips)))))
	     (member* a l))))

(test leftmost
  (is (equal? (let ((l ' ((potato) (chips ((with) fish) (chips)))))
		(leftmost l))
	      'potato))
  (is (equal? (let ((l '(((hot) (tuna (and))) cheese)))
		(leftmost l))
	      'hot))
  (is (equal? (let ((l '(((() four)) 17 (seventeen))))
		(leftmost l))
	      '()))
  (is (equal? (let ((l '()))
		(leftmost l))
	      '())))

(test eqlist?
  (is-true (let ((l1 '()) (l2 '()))
	     (eqlist? l1 l2)))
  (is-false (let ((l1 '()) (l2 '(1)))
	      (eqlist? l1 l2)))
  (is-true (let ((l1 '((1))) (l2 '((1))))
	     (eqlist? l1 l2)))
  (is-false (let ((l1 '(1 (2 (3)))) (l2 '(1 (2 ()))))
	      (eqlist? l1 l2)))
  (is-false (let ((l1 '((((1))) (2 (3)))) (l2 '(((1)) (2 ()))))
	     (eqlist? l1 l2)))
  (is-true (let ((l1 '(strawberry ice cream))
		 (l2 '(strawberry ice cream)))
	     (eqlist? l1 l2)))
  (is-false (let ((l1 '(strawberry ice cream))
		  (l2 '(strawberry cream ice)))
	      (eqlist? l1 l2)))
  (is-false (let ((l1 '(banana ((split))))
		  (l2 '((banana) (split))))
	      (eqlist? l1 l2)))
  (is-false (let ((l1 '(beef ((sausage)) (and (soda))))
		  (l2 '(beef ((salami)) (and (soda)))))
	      (eqlist? l1 l2)))
  (is-true (let ((l1 '(beef ((sausage)) (and (soda))))
		 (l2 '(beef ((sausage)) (and (soda)))))
	     (eqlist? l1 l2))))
