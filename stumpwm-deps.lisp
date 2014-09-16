(load (merge-pathnames "quicklisp/setup.lisp" (user-homedir-pathname)))
(ql:add-to-init-file)
(ql:quickload '("clx" "cl-ppcre"))

