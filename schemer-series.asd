(defsystem :schemer-series
  :version "0.1.0"
  :author "Nalin Ranjan"
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main")
		 (:file "scheme-extensions")
		 (:file "chapter2")
		 (:file "chapter3")
		 (:file "chapter4")
		 (:file "chapter5")
		 (:file "chapter6")
		 (:file "chapter7")
		 (:file "chapter8")
		 (:file "chapter9")
		 (:file "chapter10"))))
  :description "The Little Schemer, The Seasoned Schemer"
  :in-order-to ((test-op (test-op "schemer-series/tests"))))

(defsystem :schemer-series/tests
  :author "Nalin Ranjan"
  :license ""
  :depends-on (:schemer-series
	       :fiveam)
  :serial t
  :components ((:module "tests"
		:serial t
                :components
                ((:file "main")
		 (:file "chapter1")
		 (:file "chapter2")
		 (:file "chapter3")
		 (:file "chapter4")
		 (:file "chapter5")
		 (:file "chapter6")
		 (:file "chapter7")
		 (:file "chapter8")
		 (:file "chapter9")
		 (:file "chapter10"))))
  :description "Test system for schemer-series"
  :perform (test-op (op _) (symbol-call :fiveam :run-all-tests)))
