(in-package :schemer-series/tests)

(def-suite chapter13 :in the-seasoned-schemer)
(in-suite chapter13)

(test intersect-all
  (is (equal? (let ((lset '((1 2 3) (3 4 5))))
		(intersect-all lset))
	      '(3)))
  (is (equal? (let ((lset '((3 mangoes and3)
			    (3 kiwis and)
			    (3 hamburgers))))
		(intersect-all lset))
	      '(3)))
  (is (equal? (let ((lset '((3 steaks and)
			    (no food and)
			    (three baked potatoes)
			    (3 diet hamburgers))))
		(intersect-all lset))
	      '()))
  (is (equal? (let ((lset '((3 mangoes and)
			    ()
			    (3 diet hamburgers))))
		(intersect-all lset))
	      '())))

(test rember-beyond-first
  (is (equal? (let ((a 'roots)
		    (lat '(noodles sphagetti spatzle bean-thread roots potatoes yam others rice)))
		(rember-beyond-first a lat))
	      '(noodles sphagetti spatzle bean-thread)))
  (is (equal? (let ((a 'others)
		    (lat '(noodles sphagetti spatzle bean-thread roots potatoes yam others rice)))
		(rember-beyond-first a lat))
	      '(noodles sphagetti spatzle bean-thread roots potatoes yam)))
  (is (equal? (let ((a 'sweetthing)
		    (lat '(noodles sphagetti spatzle bean-thread roots potatoes yam others rice)))
		(rember-beyond-first a lat))
	      '(noodles sphagetti spatzle bean-thread roots potatoes yam others rice)))
  (is (equal? (let ((a 'desserts)
		    (lat '(cookies chocolate mints caramel delight ginger snaps desserts chocolate mousse vanilla ice cream German chocolate cake more desserts gingerbreadman chocolate chip brownies)))
		(rember-beyond-first a lat))
	      '(cookies chocolate mints caramel delight ginger snaps))))

(test rember-upto-last
  (is (equal? (let ((a 'roots)
		    (lat '(noodles spaghetti spatzle bean-thread roots potatoes yam others rice)))
		(rember-upto-last a lat))
	      '(potatoes yam others rice)))
  (is (equal? (let ((a 'sweetthing)
		    (lat '(noodles spaghetti spatzle bean-thread roots potatoes yam others rice)))
		(rember-upto-last a lat))
	      '(noodles spaghetti spatzle bean-thread roots potatoes yam others rice)))
  (is (equal? (let ((a 'cookies)
		    (lat '(cookies chocolate mints caramel delight ginger snaps desserts chocolate mousse vanilla ice cream German chocolate cake more cookies gingerbreadman chocolate chip brownies)))
		(rember-upto-last a lat))
	      '(gingerbreadman chocolate chip brownies))))