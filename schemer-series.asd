(defsystem :schemer-series
  :version "0.1.0"
  :author "Nalin Ranjan"
  :license ""
  :depends-on ()
  :serial t
  :components ((:module "package"
		:components
			((:file "main")
			 (:file "scheme-extensions")))
	       (:module "little-schemer"
                :components
			((:file "chapter2")
			 (:file "chapter3")
			 (:file "chapter4")
			 (:file "chapter5")
			 (:file "chapter6")
			 (:file "chapter7")
			 (:file "chapter8")
			 (:file "chapter9")
			 (:file "chapter10")))
	       (:module "seasoned-schemer"
                :components
			((:file "chapter11")
			 (:file "chapter12")
			 ;; (:file "chapter13")
			 ;; (:file "chapter14")
			 ;; (:file "chapter15")
			 ;; (:file "chapter16")
			 ;; (:file "chapter17")
			 ;; (:file "chapter18")
			 ;; (:file "chapter19")
			 )))
  :description "The Little Schemer, The Seasoned Schemer"
  :in-order-to ((test-op (test-op "schemer-series/tests"))))

(defsystem :schemer-series/tests
  :author "Nalin Ranjan"
  :license ""
  :depends-on (:schemer-series
	       :fiveam)
  :serial t
  :components ((:module "little-schemer-tests"
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
		 (:file "chapter10")))
	       (:module "seasoned-schemer-tests"
		:serial t
                :components
                ((:file "main")
		 (:file "chapter11")
		 (:file "chapter12")
		 ;; (:file "chapter3")
		 ;; (:file "chapter4")
		 ;; (:file "chapter5")
		 ;; (:file "chapter6")
		 ;; (:file "chapter7")
		 ;; (:file "chapter8")
		 ;; (:file "chapter9")
		 ;; (:file "chapter10")
		 )))
  :description "Test system for schemer-series"
  :perform (test-op (op _) (symbol-call :fiveam :run-all-tests)))
