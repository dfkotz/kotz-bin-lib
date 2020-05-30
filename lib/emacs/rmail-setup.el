;;; mail and rmail setup for dfk
(global-set-key "\M-m" 'rmail)

(setq mail-archive-file-name "/u/dfk/OutRmail")

(setq mail-signature t)

(setq mail-default-reply-to "David Kotz <kotz@cs.dartmouth.edu>")

; mailcrypt (PGP) stuff
; (autoload 'mc-install-write-mode "mailcrypt" nil t)
; (autoload 'mc-install-read-mode "mailcrypt" nil t)
; (add-hook 'mail-mode-hook 'mc-install-write-mode)
; (add-hook 'rmail-mode-hook 'mc-install-read-mode)
; (add-hook 'rmail-summary-mode-hook 'mc-install-read-mode)
; (add-hook 'gnus-summary-mode-hook 'mc-install-read-mode)
; (add-hook 'news-reply-mode-hook 'mc-install-write-mode)
; (setq  mc-encrypt-for-me t)	; when encrypting, allow me to read too
; (setq mc-passwd-timeout 120)  ; forget my passphrase after 120 seconds

;;;WARNING: this is not my own rmail stuff!!
;;; DFK taken from Cliff Stein, and modified

(defvar rmail-reply-unixly nil
  "If true, this makes safe-rmail-reply act like rmail-reply; 
i.e., replying to a multi-victim message will send to everyone 
by default, including the people that you least want to get
the letter.")

(defun safe-rmail-reply (not-just-sender)
  "Reply, just like rmail-reply except that it normally does *NOT* 
CC: all the recipients of the other message.  With a prefix argument,
it does.  Note: if the global variable rmail-reply-unixly is true, it acts 
just like rmail-reply."
  (interactive "P")
  (if rmail-reply-unixly
      (rmail-reply not-just-sender)
    (rmail-reply (not not-just-sender)))
  )

;;; (load-library "sendmail")
(require 'sendmail)

(defun my-rmail-mode-hook ()
  (setq mode-line-format
        (quote ("-%1*%1*- %b      %f %[("
                mode-line-process  ")%]--%3p--%M%-")))
  (define-key rmail-mode-map "R" 'safe-rmail-reply) ;;; DFK reversed
  (define-key rmail-mode-map "r" 'rmail-reply) ;;; DFK reversed 
  (define-key rmail-mode-map "P" 'print-buffer)
  (define-key mail-mode-map "\C-c\C-c" 'mail-send-and-exit-nicely)
  (define-key mail-mode-map "\C-c\C-s" 'mail-send-and-exit-nicely)
  (define-key rmail-mode-map "b" 'my-rmail-resend-to-mac)
  )

(setq rmail-primary-inbox-list 
      '("/net/mail/dfksave")
)

; '("/net/mail/dfk" "/net/mail/dfkplot" "/net/mail/dfksave")

(add-hook 'rmail-mode-hook 'my-rmail-mode-hook)

(setq rmail-ignored-headers 
  (concat rmail-ignored-headers "\\|^resent-[a-zA-Z]+:\\|^apparently-to:"))

; from Fred Henle, to make auto-save files be mode 0600
(add-hook 'auto-save-hook
	  (function (lambda ()
		      (let ((dog buffer-auto-save-file-name))
			(cond ((and dog (buffer-modified-p))
			       (cond ((not (file-exists-p dog))
				      (write-region (point-min) (point-max) dog)
				      (set-buffer-auto-saved)))
			       (set-file-modes dog 384)))))))

(defun my-mail-mode-hook ()
  (define-key mail-mode-map "\C-c\C-c" 'mail-send-and-exit-nicely)
  (define-key mail-mode-map "\C-c\C-s" 'mail-send-and-exit-nicely)
  (define-key mail-mode-map "\C-cs" 'mail-send-and-exit-nicely)
  (setq buffer-auto-save-file-name
	(concat "~/"
		(file-name-nondirectory
		 buffer-auto-save-file-name)))
  )

(add-hook 'mail-mode-hook 'my-mail-mode-hook)

(defun mail-sent-mode-line ()
  (setq mode-line-format 
        "-%1*%1*- %b      %f %[(%m, sent)%]--%3p--%M%-"))

(defun mail-send-nicely ()
  "Like mail-send, but adjusts the mode line."
  (interactive)
  (mail-send)
  (mail-sent-mode-line))

(defun mail-send-and-exit-nicely ()
  "Send message like mail-send, then, if no errors, exit from mail buffer."
  (interactive)
  (mail-send)
  (mail-sent-mode-line)
  (bury-buffer (current-buffer))
  (if (eq (next-window (selected-window)) (selected-window))
      (switch-to-buffer (other-buffer (current-buffer)))
    (delete-window)))

;; new function from Tom Cormen
(defun my-rmail-resend-to-mac ()
  (interactive)
  (message "Bouncing message to David.Kotz@mac.dartmouth.edu...")
  (rmail-resend "David.Kotz@mac.dartmouth.edu")
  (message "Bouncing message to David.Kotz@mac.dartmouth.edu... done.")
  )


; end of mail and rmail stuff
