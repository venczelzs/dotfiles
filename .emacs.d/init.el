;;; ~/emacs.d/init.el

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

(require 'yasnippet)
(yas-global-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(custom-enabled-themes (quote (misterioso)))
 '(org-agenda-files
   (quote
    ("~/.emacs.d/org/org-config.el" "~/org/email.org" "~/org/munka.org" "~/org/sajat.org" "~/org/suli.org" "~/org/tanulas.org" "~/Dokumentumok/EGYETEM/TDK/org/tdk.org"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; Global key bindings
(define-key global-map (kbd "C-c i") 'iedit-mode)
(global-set-key (kbd "C-c r") 'rectangle-mark-mode)
(global-set-key (kbd "<f5>") (lambda() (interactive)(shell)))
(global-set-key (kbd "<f6>") (lambda() (interactive)(find-file "~/.emacs.d/init.el")))
(global-set-key (kbd "<f7>") (lambda() (interactive)(org-agenda-list)))
;; (global-set-key (kbd "<f9>") (lambda() (interactive)(run-sage RET))) ; TODO kbd for run-sage

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
