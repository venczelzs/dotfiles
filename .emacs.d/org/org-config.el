;;; ~/.emacs.d/org/org-config.el

;;; Activating org mode
(require 'org)
(global-set-key (kbd "\C-c l") 'org-store-link)
(global-set-key (kbd "\C-c a") 'org-agenda)
(global-set-key (kbd "\C-c c") 'org-capture)
(setq org-log-done)

;;; Key binding fixes
;; (define-key global-map (kbd "C-M-RET") 'org-insert-todo-heading)

(setq org-agenda-files (list "~/org/egyeb.org"
			     "~/org/email.org"
			     "~/org/munka.org"
			     "~/org/sajat.org"
			     "~/org/suli.org"
			     "~/org/tanulas.org"
			     "~/org/tdk.org"
			     "~/org/vasarolni.org"
			     "~/org/szoc.org"
			     "~/org/sec.org"))
