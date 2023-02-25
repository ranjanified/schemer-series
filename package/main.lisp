(defpackage schemer-series
  (:use :cl)
  (:export
   :eq?
   :equal?
   :list?
   :null?
   :atom?
   :sexp?
   :boolean?
   :number?
   :zero?
   :even?
   :^
   :member?
   :lat?
   :multisubst
   :multi-insert-L
   :multi-insert-R
   :multirember
   :subst2
   :substi-tute
   :insertL
   :insertR
   :firsts
   :seconds
   :rember
   :all-nums
   :no-nums
   :equan?
   :tup?
   :sub1
   :add1
   :occur
   :one?
   :plus
   :minus
   :mul
   :div
   :greater
   :lesser
   :pick
   :rempick
   :tup+
   :addtup
   :lat-length
   :rember*
   :insertL*
   :insertR*
   :occur*
   :subst*
   :member*
   :leftmost
   :eqlist?
   :numbered?
   :value
   :sero?
   :edd1
   :zub1
   :pluz
   :set?
   :makeset
   :subset?
   :eqset?
   :intersect?
   :intersect
   :union-1
   :set-diff
   :intersectall
   :a-pair?
   :first-l
   :second-l
   :third-l
   :build
   :rel
   :fun?
   :revpair
   :revrel
   :fullfun?
   :rember-f
   :eq?-c
   :insertL-f
   :insertR-f
   :insertS-f
   :yyy
   :multirember-f
   :multirember-eq?
   :multiremberT
   :multirember&Co
   :multiinsertLR
   :multiinsertLR&Co
   :evens-only*
   :evens-only*&Co
   :looking
   :shift
   :align
   :length*
   :weight*
   :shuffle
   :lookup-in-entry
   :lookup-in-table
   ;; Seasoned Schemer
   ;; Chapter 11
   :two-in-a-row?
   :sum-of-prefixes
   :scramble

   ;; chapter 12
   :multi-rember
   :multi-rember-f
   :member-?
   :uni-on
   :protected-two-in-a-row?
   :protected-scramble

   ;; Chapter 13
   :intersect-all
   :rember-beyond-first
   :rember-upto-last
   ))


(defpackage :schemer-series/tests
  (:use :cl :fiveam
	:schemer-series))
