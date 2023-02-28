(in-package :schemer-series/tests)

(def-suite chapter16 :in the-seasoned-schemer)
(in-suite chapter16)

(test sweet-tooth
  (is (eqlist? (let ((x 'chocolate))
		 (sweet-tooth x))
	       (list 'chocolate schemer-series::'cake)))
  (is (eqlist? (let ((x 'fruit))
		 (sweet-tooth x))
	       (list 'fruit schemer-series::'cake))))

(test sweet-toothL
  (is (eqlist? (let ((food 'chocolate))
		 (sweet-toothL food))
	       (list 'chocolate schemer-series::'cake)))
  (is (eqlist? (let ((food 'fruit))
		 (sweet-toothL food))
	       (list 'fruit schemer-series::'cake)))
  (is (eqlist? (let ((food 'cheese))
		 (sweet-toothL food))
	       (list 'cheese schemer-series::'cake)))
  (is (eqlist? (let ((food 'carrot))
		 (sweet-toothL food))
	       (list 'carrot schemer-series::'cake))))

(test sweet-toothR
  (is (eqlist? (let ((food 'chocolate))
		 (sweet-toothL food))
	       (list 'chocolate schemer-series::'cake)))
  (is (eqlist? (let ((food 'fruit))
		 (sweet-toothL food))
	       (list 'fruit schemer-series::'cake)))
  (is (eqlist? (let ((food 'cheese))
		 (sweet-toothL food))
	       (list 'cheese schemer-series::'cake)))
  (is (eqlist? (let ((food 'carrot))
		 (sweet-toothL food))
	       (list 'carrot schemer-series::'cake))))

(test deep
  (is (eqlist? (let ((m 3))
		 (deep m))
	       (list (list (list SCHEMER-SERIES::'pizza))))))

(test deepR
  (is (eqlist? (let ((m 3))
		 (deepR m))
	       (list (list (list SCHEMER-SERIES::'pizza)))))
  (is (eqlist? (let ((m 5))
		 (deepR m))
	       (list (list (list (list (list SCHEMER-SERIES::'pizza))))))))

(test find-l
  (is (eqlist? (let ((x 1))
		 (find-l 2 '() '()))
	       '())))
