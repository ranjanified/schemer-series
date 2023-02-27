(in-package :schemer-series/tests)

(def-suite chapter15 :in the-seasoned-schemer)
(in-suite chapter15)

(test gourmet
  (is (eqlist? (gourmet 'onion)
	       (list 'onion schemer-series::'skins))))

(test gourmand
  (is (eqlist? (let ((food 'potato))
		 (gourmand food))
	       '(potato potato)))
  (is (eqlist? (let ((food 'rice))
		 (gourmand food))
	       '(rice rice))))

(test dinerR
  (is (eqlist? (let ((food 'pecanpie))
		 (dinerR food))
	       (list schemer-series::'milkshake 'pecanpie))))

(test omnivore
  (is (eqlist? (let ((food 'bouillabaisse))
		 (omnivore food))
	       '(bouillabaisse bouillabaisse))))

(test gobbler
  (is (eqlist? (let ((food 'gumbo))
		 (gobbler food))
	       '(gumbo gumbo))))

(test nibbler
  (is (eqlist? (let ((food 'cheerio))
		 (gobbler food))
	       '(cheerio cheerio))))

(test glutton
  (is (eqlist? (let ((food 'garlic))
		 (glutton food))
	       (list SCHEMER-SERIES::'more 'garlic SCHEMER-SERIES::'more 'garlic))))

