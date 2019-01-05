;;; ~/.emacs.d/cpp/cpp-config.el
					; let's define a function which initializes auto-complete-c-headers and gets called for c/c++ hooks
					; these pathes are obtained by the command gcc -xc++ -v -
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/include/c++/6")
  (add-to-list 'achead:include-directories'"/usr/include/x86_64-linux-gnu/c++/6")
  (add-to-list 'achead:include-directories '"/usr/include/c++/6/backward")
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-linux-gnu/6/include")
  (add-to-list 'achead:include-directories '"/usr/local/include")
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-linux-gnu/6/include-fixed")
  (add-to-list 'achead:include-directories '"/usr/include/x86_64-linux-gnu")
  (add-to-list 'achead:include-directories '"/usr/include")
  )
					; now let's call this function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)
					; turn on Semantic
(semantic-mode 1)
					; let's define a function which adds semantic as a suggestion backend to auto complete
					; and hook this function to c-mode-common-hook
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic))
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
					; turn on ede mode
(global-ede-mode 1)
					; create a project for our program.
;; (ede-cpp-root-project "my project" :file "~/demos/my_program/src/main.cpp"
;; 		      :include-path '("/../my_inc"))
					; you can use system-include-path for setting up the system header file locations.
					; turn on automatic reparsing of open buffers in semantic
(global-semantic-idle-scheduler-mode 1)
