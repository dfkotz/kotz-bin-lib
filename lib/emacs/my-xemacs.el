;;; ------------------------------------------------------------------

;;; If running under the X Window System...

;(if under-xemacs (progn
;	      (require 'font-lock)
;	      (add-hook 'emacs-lisp-mode-hook	'turn-on-font-lock)
;	      (add-hook 'lisp-mode-hook		'turn-on-font-lock)
;	      (add-hook 'c-mode-hook		'turn-on-font-lock)
;	      (add-hook 'c++-mode-hook		'turn-on-font-lock)
;	      (add-hook 'perl-mode-hook		'turn-on-font-lock)
;	      (add-hook 'tex-mode-hook		'turn-on-font-lock)
;	      (add-hook 'texinfo-mode-hook	'turn-on-font-lock)
;	      (add-hook 'postscript-mode-hook	'turn-on-font-lock)
;	      (add-hook 'dired-mode-hook	'turn-on-font-lock)
;	      (add-hook 'ada-mode-hook		'turn-on-font-lock)
;	      (add-hook 'ksh-mode-hook		'turn-on-font-lock)
;	      (add-hook 'csh-mode-hook		'turn-on-font-lock)
;	      (add-hook 'xrdb-mode-hook		'turn-on-font-lock)
;	      (add-hook 'compilation-mode-hook	'turn-on-font-lock)
;	      (add-hook 'matlab-mode-hook	'turn-on-font-lock)
;	      (add-hook 'octave-mode-hook	'turn-on-font-lock)

;	      (setq-default font-lock-auto-fontify t
;			    font-lock-use-fonts nil
;			    font-lock-use-colors nil
;			    font-lock-use-maximal-decoration t
;			    font-lock-mode-enable-list nil
;			    font-lock-mode-disable-list nil)
;	      ))

;;; ------------------------------------------------------------------

;;; Set useful keybindings for the keypad:

(global-set-key [kp-1] 'beginning-of-line)
(global-set-key [kp-2] 'next-line)
(global-set-key [kp-3] 'end-of-line)
(global-set-key [kp-4] 'backward-word)
(global-set-key [kp-5] 'scroll-down)
(global-set-key [kp-6] 'forward-word)
(global-set-key [kp-7] 'backward-char)
(global-set-key [kp-8] 'previous-line)
(global-set-key [kp-9] 'forward-char)
(global-set-key [kp-0] 'beginning-of-buffer)
(global-set-key [kp-enter] 'end-of-buffer)
(global-set-key [kp-decimal] 'scroll-up)
(global-set-key [kp-period] 'scroll-up)

;;; Some other useful keybindings:

(global-set-key [(meta f1)] 'compile)
(global-set-key [(meta f2)] 'next-error)

