;;; ~/emacs.d/init.el

(setq init-dir "~/.emacs.d/")
(setq custom-file (concat init-dir "custom.el"))
(load custom-file :noerror)

;;; Secure Emacs
(require 'cl)
(setq tls-checktrust t)
(setq python (executable-find "python"))

;;; Setup TLS certification
(let ((trustfile
       (replace-regexp-in-string
	"\\\\" "/"
	(replace-regexp-in-string
	 "\n" ""
	 (shell-command-to-string (concat python " -m certifi"))))))
  (setq tls-program
	(list
	 (format "gnutls-cli%s --x509cafile %s -p %%p %%h"
		 (if (eq window-system 'w32) ".exe" "") trustfile)))
  (setq gnutls-verify-error t)
  (setq gnutls-trustfiles (list trustfile)))

;;; Test whether TLS is configured well
;; (let ((bad-hosts
;;        (loop for bad
;; 	     in `("https://wrong.host.badssl.com/"
;; 		  "https://self-signed.badssl.com/")
;; 	     if (condition-case e
;; 		    (url-retrieve
;; 		     bad (lambda (retrieved) t))
;; 		  (error nil))
;; 	     collect bad)))
;;   (if bad-hosts
;;       (error (format "tls misconfigured; retrieved %s ok"
;; 		     bad-hosts))
;;     (url-retrieve "https://badssl.com"
;; 		  (lambda (retrieved) t))))

;;; Setting up MELPA ; See in custom-set-vars in custom.el
(require 'package)

(defvar gnu '("gnu" . "https://elpa.gnu.org/packages/"))
(defvar melpa '("melpa" . "https://melpa.org/packages/"))
(defvar melpa-stable '("melpa-stable" . "https://stable.melpa.org/packages/"))
(defvar org-elpa '("org" . "http://orgmode.org/elpa/"))

;;; Add marmalade to package repos
(setq package-archives nil)
(add-to-list 'package-archives melpa-stable t)
(add-to-list 'package-archives melpa t)
(add-to-list 'package-archives gnu t)
(add-to-list 'package-archives org-elpa t)

(package-initialize)

(unless (and (file-exists-p (concat init-dir "elpa/archives/gnu"))
             (file-exists-p (concat init-dir "elpa/archives/melpa"))
             (file-exists-p (concat init-dir "elpa/archives/melpa-stable")))
  (package-refresh-contents))

(defun packages-install (&rest packages)
  (message "running packages-install")
  (mapc (lambda (package)
          (let ((name (car package))
                (repo (cdr package)))
            (when (not (package-installed-p name))
              (let ((package-archives (list repo)))
                (package-initialize)
                (package-install name)))))
        packages)
  (package-initialize)
  (delete-other-windows))

;; Install extensions if they're missing
(defun init--install-packages ()
  (message "Lets install some packages")
  (packages-install
   ;; Since use-package this is the only entry here
   ;; ALWAYS try to use use-package!
   (cons 'use-package melpa)
   ))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

(use-package diminish
	     :ensure t)

;; Just to move fast
(fset 'yes-or-no-p 'y-or-n-p)

;;; AC & Yas
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

(require 'yasnippet)
(yas-global-mode 1)

;;; Global key bindings
(define-key global-map (kbd "M-p") 'cua-mode)
(define-key global-map (kbd "C-c i") 'iedit-mode)
(global-set-key (kbd "C-c r") 'rectangle-mark-mode)
(global-set-key (kbd "<f5>") (lambda() (interactive)(shell)))
(global-set-key (kbd "<f6>") (lambda() (interactive)
			       (find-file "~/.emacs.d/init.el")))
(global-set-key (kbd "<f7>") (lambda() (interactive)(org-agenda-list)))
;;; TODO kbd for run-sage
;; (global-set-key (kbd "<f9>") (lambda() (interactive)(run-sage RET)))

;;; Set prog-mode hooks
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'outline-minor-mode)
(add-hook 'prog-mode-hook 'linum-mode)

;;; Load c++ config
(add-to-list 'load-path ".emacs.d/cpp")
(load-library "cpp-config.el")

;;; Load org-mode configuration...
(add-to-list 'load-path ".emacs.d/org")
(load-library "org-config.el")

;;; Load sage config
(add-to-list 'load-path ".emacs.d/sage")
(load-library "sage-config.el")

;;; Modify the backup directory to not to flood the working directory
;;; with *~ backup files
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old
      )

;;; Startup tasks:
(setq ring-bell-function 'ignore) ; No bell
(tool-bar-mode -1) ; No big toolbar
(setq inhibit-startup-message t) ; No welcome screen
;; (setq initial-scratch-message nil) ; No scratch buffer
(org-agenda-list 1)
(delete-other-windows)

;;; TODO setup ace-window properly
;; (require 'ace-window)
;; (global-set-key (kbd "C-c p") 'ace-window)
