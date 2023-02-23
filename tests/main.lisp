;; NOTE: To run this test file, execute `(asdf:test-system :schemer-series)' in your Lisp.

(defpackage :schemer-series/tests
  (:use :cl :fiveam
	:schemer-series))

(in-package :schemer-series/tests)
(def-suite the-little-schemer)

