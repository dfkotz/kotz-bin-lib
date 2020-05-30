;
;     DON'T FORGET TO RECOMPILE!
;
; David Kotz (kotz@cs.dartmouth.edu)
;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Some overall stuff

;;; Preserve modes, ownerships, and hard links of edited files.
(setq backup-by-copying-when-linked t)

;;; Make sure there are newlines in each file, dammit
(setq require-final-newline t)

(put 'eval-expression 'disabled nil)

(setq major-mode 'text-mode)

;;; for color-based syntax highlighting
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;;; indent with spaces, not tabs, for portability
(setq-default indent-tabs-mode nil)

;;; ------------------------------------------------------------------
;; HTML helper mode

 (autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
; (setq html-helper-do-write-file-hooks t)
; (setq html-helper-build-new-buffer t)
; (setq html-helper-address-string 
;   "<a href=\"http://www.cs.dartmouth.edu/~dfk/\">David Kotz</a>")
 
 (defvar html-helper-new-buffer-template
   '("<html> <head>\n"
     "<title>" p "</title>\n</head>\n\n"
     "<body>\n"
     "<h1>" p "</h1>\n\n"
     p
     "\n\n<hr>\n"
     "<address>" html-helper-address-string "</address>\n"
     html-helper-timestamp-start
     html-helper-timestamp-end
     "\n</body> </html>\n")
   "*Template for new buffers, inserted by html-helper-insert-new-buffer-strings if html-helper-build-new-buffer is set to t")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Global key bindings changes
;;;
; redefine help character to be ESC-?
(define-key global-map "\M-?" 'help-command)
; ... and redefine C-h to be delete-backwards
(define-key global-map "\^h" 'delete-backward-char)

(global-set-key [S-delete] 'delete-backward-char)

(global-set-key "\M- " 'just-one-space)
; the following interfere with copy-paste from MacOS terminal
;(global-set-key "\M-[" 'backward-paragraph)
;(global-set-key "\M-]" 'forward-paragraph)

(global-set-key "\C-xg" 'goto-line)
(global-set-key "\C-xc" 'compile)
(setq compile-command "make -k ")

(global-set-key "\M-s" 'tags-search)
(global-set-key "\M-r" 'tags-query-replace)
(global-set-key "\M-n" 'tags-loop-continue)

(global-set-key "\C-x%" 'query-replace-regexp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Filename extensions, and those to ignore during filename completion

(setq auto-mode-alist (cons (cons "\\.bib$" 'bibtex-mode) auto-mode-alist))
(setq auto-mode-alist (cons (cons "\\.tex$" 'latex-mode) auto-mode-alist))
(setq auto-mode-alist (cons (cons "\\.html$" 'html-helper-mode) auto-mode-alist))
(setq auto-mode-alist (cons (cons "\\.htmltop$" 'html-helper-mode) auto-mode-alist))
(setq auto-mode-alist (cons (cons "\\.shtml$" 'html-helper-mode) auto-mode-alist))
(setq auto-mode-alist (cons (cons "\\.htmlf$" 'html-helper-mode) auto-mode-alist))
(setq auto-mode-alist (cons (cons "\\.m$" 'text-mode) auto-mode-alist))
(setq auto-mode-alist (cons (cons "\\.csl$" 'xml-mode) auto-mode-alist))
(setq auto-mode-alist (cons (cons "\\.xml$" 'xml-mode) auto-mode-alist))

(setq completion-ignored-extensions '(".o" ".bbl" "blg" "~" ".dvi" ".log" ".aux" ".lof" ".lot" ".toc" ".class" ".syms" ".a" ".pdf" ".ps"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; C-mode hook
(setq c-mode-hook
      '(lambda ()
	 (setq c-indent-level 4)
	 (setq c-label-offset 0)
	 (setq comment-column 30)
	 (setq tab-stop-list '(4 8 12 16 20 24 30 40 50 60 70 80 90 100))
	 )
      )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LaTeX mode should run detex when spell-checking
; options -lnw are: latex, no \include processing, one word per line output
(add-hook 'latex-mode-hook
      (function
       (lambda ()
	 (make-local-variable 'outline-regexp)
	 (outline-minor-mode t)
	 (setq outline-regexp "\\\\\\(sub\\)*section")
	 )
       )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Add bibtex mode
(autoload 'bibtex-mode "bibtex" "BibTeX mode" t)
; and redefine some of the key bindings
; and add my favorite extra fields 
(setq bibtex-mode-hook
   '(lambda ()
      (setq fill-column 999999)
      (define-key bibtex-mode-map [?\C-c ?\C-'] 'bibtex-remove-delimiters)
      (define-key bibtex-mode-map "\C-c\C-eI" 'bibtex-InBook)
      (define-key bibtex-mode-map "\C-c\C-e\C-i" 'bibtex-InProceedings)
      (define-key bibtex-mode-map "\C-c\C-eM" 'bibtex-Manual)
      (define-key bibtex-mode-map "\C-c\C-e\C-m" 'bibtex-Misc)
      (define-key bibtex-mode-map "\M-q" 'bibtex-fill-entry)
      (setq bibtex-include-OPTannote nil)
      (setq bibtex-include-OPTkey nil)
      (setq bibtex-maintain-sorted-entries nil)
      (setq bibtex-field-delimiters 'braces)
      (setq bibtex-entry-delimiters 'braces)
      (setq bibtex-text-indentation 18)
      (setq bibtex-entry-format
	    '(opts-or-alts numerical-fields last-comma delimeters))
      (setq bibtex-string-files '("macros.bib"))
      (setq bibtex-user-optional-fields 
	    '( ("earlier" "earlier version of paper") 
	       ("later" "later version of paper") 
	       ("DOI" "DOI for paper")
	       ("URL" "URL for paper")
	       ("vitatype" "for my papers") 
	       ("reviewed" "pending, peer, poster, invited, maybe, none")
	       ("acceptpercent" "acceptance percentage, for my papers") 
	       ("copyright" "copyright holder") 
	       ("projects" "project, or list of projects") 
	       ("keywords" "list of keywords") 
	       ("abstract" "abstract")))
      )
   )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; text-mode hook; auto fill
(setq text-mode-hook
      '(lambda () 
	 (turn-on-auto-fill)
	 (setq fill-column 70)
	 )
      )


;;; ------------------------------------------------------------------
;;; Stuff borrowed from CS department master emacs files
;;; ------------------------------------------------------------------

;;; Set directories appropriately.

(setq user-home-directory (getenv "HOME"))
(setq a-home-directory (concat "/a" (substring user-home-directory 4)))

(setq directory-abbrev-alist
      (append (list (cons (concat "^/u/" (user-login-name) "/") "~/")
		    (cons (concat "^" user-home-directory "/") "~/")
		    (cons (concat "^" a-home-directory "/") "~/"))
	      directory-abbrev-alist))

;;; ------------------------------------------------------------------

;;; Use a fancier auto-fill-mode:

(require 'filladapt)
(add-hook 'text-mode-hook 'turn-on-filladapt-mode)
(add-hook 'c-mode-hook 'turn-off-filladapt-mode)

;;; ------------------------------------------------------------------

;;; Make text-mode auto-fill (word-wrap) by default:

(add-hook 'text-mode-hook
	  (function (lambda () (auto-fill-mode 1))))

;;; ------------------------------------------------------------------

;;; Make the current line number appear in the modeline:

(line-number-mode t)

;;; Make the date and time to appear in the modeline:

;; (display-time)
;; (setq display-time-day-and-date t)

;;; ------------------------------------------------------------------

