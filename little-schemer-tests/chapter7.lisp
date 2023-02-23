(in-package :schemer-series/tests)

(def-suite chapter7 :in the-little-schemer)
(in-suite chapter7)

(test set?
  (is-true (set? '()))
  (is-false (let ((lat '(apple peaches apple plum))) (set? lat)))
  (is-true (let ((lat '(apples peaches pears plums))) (set? lat)))
  (is-false (let ((lat '(apple 3 pear 4 9 apple 3 4))) (set? lat))))

(test makeset
  (is (equal? (let ((lat '())) (makeset lat)) '()))
  (is (equal? (let ((lat '(apple peach pear peach plum apple lemon peach)))
		(makeset lat))
	      '(pear plum apple lemon peach))))

(test subset?
  (is-true (let ((set1 '())(set2 '()))(subset? set1 set2)))
  (is-true (let ((set1 '(5 chicken wings))
		 (set2 '(5 hamburgers 2 pieces fried chicken and light duckling wings)))
	     (subset? set1 set2)))
  (is-false (let ((set1 '(4 pounds of horseradish))
		 (set2 '(four pounds chicken and 5 ounces horseradish)))
	     (subset? set1 set2))))

(test eqset?
  (is-true (let ((set1 '()) (set2 '())) (eqset? set1 set2)))
  (is-true (let ((set1 '(6 large chickens with wings))
		 (set2 '(6 large chickens with wings)))
	     (eqset? set1 set2))))

(test intersect?
  (is-false (let ((set1 '()) (set2 '()))
	     (intersect? set1 set2)))
  (is-false (let ((set1 '()) (set2 '(1)))
	     (intersect? set1 set2)))
  (is-true (let ((set1 '(stewed tomatoes and macroni))
		 (set2 '(macroni and cheese)))
	     (intersect? set1 set2))))

(test intersect
  (is (equal? (let ((set1 '()) (set2 '())) (intersect set1 set2))
	      '()))
  (is (equal? (let ((set1 '(stewed tomatoes and macaroni))
		    (set2 '(macaroni and cheese))) (intersect set1 set2))
	      '(and macaroni))))

(test union-1
  (is (equal? (let ((set1 '(stewed tomatoes and macaroni casserole))
		    (set2 '(macaroni and cheese)))
		(union-1 set1 set2))
	      '(stewed tomatoes casserole macaroni and cheese))))

(test set-diff
  (is (equal? (let ((set1 '(2 3 4))
		    (set2 '(3 4 6 7)))
		(set-diff set1 set2))
	      '(2))))

(test intersectall
  (is (equal? (let ((l-set '((6 pears and) (3 peaches and 6 peppers)
			     (8 pears and 6 plums)
			     (and 6 prunes with some apples))))
		(intersectall l-set))
	      '(6 and))))

(test a-pair?
  (is-true (let ((l '(pear pear))) (a-pair? l)))
  (is-true (let ((l '(3 7))) (a-pair? l)))
  (is-true (let ((l '((2) (pair)))) (a-pair? l)))
  (is-true (let ((l '(full (house)))) (a-pair? l))))

(test first-l
  (is (equal? (first-l '(1 2 3)) 1)))

(test second-l
  (is (equal? (second-l '(1 2 3 4)) 2)))

(test third-l
  (is (equal? (third-l '(1 2 3 4 5)) 3)))

(test build
  (is (equal? (build 1 2) '(1 2))))

(test rel
  (is-true (let ((l '())) (rel l)))
  (is-true (let ((l '((apples peaches)
		      (pumpkin pie)
		      (apples peaches))))
	     (rel l)))
  (is-true (let ((l '((apples peaches) (pumpkin pie))))
	     (rel l)))
  (is-true (let ((l ' ((4 3) (4 2) (7 6) (6 2) (3 4))))
	     (rel l))))

(test fun?
  (is-true (let ((l '((8 3) (4 2) (7 6) (6 2) (3 4)))) (fun? l)))
  (is-false (let ((l '((d 4) (b 0) (b 9) (e 5) (g 4)))) (fun? l))))

(test revrel
  (is (equal? (let ((l '((8 a)(pumpkin pie)(got sick))))
		(revrel l))
	      '((a 8)(pie pumpkin)(sick got)))))

(test fullfun?
  (is-true (let ((l '((8 3) (4 8) (7 6) (6 2) (3 4)))) (fullfun? l)))
  (is-false (let ((l '((8 3) (4 2) (7 6) (6 2) (3 4)))) (fullfun? l)))
  (is-false (let ((l '((grape raisin)(plum prune)(stewed prune))))
	      (fullfun? l)))
  (is-true (let ((l '((grape raisin)(plum prune)(stewed grape))))
	      (fullfun? l))))
