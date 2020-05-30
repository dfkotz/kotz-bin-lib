;;        by Matt Carter 1999
;; This package lets you trace into a definition of a function, a cpp macro, or a
;; typedef, and then "pop" back when you're done.  You can trace
;; arbitrarily deeply without ever losing your place.  Once you get used
;; to it you'll wonder how you ever did without it.
;; 
;; The main entry-points are push-point-chase-tag and pop-point, which
;; you can map to whatever key-sequence you like.


;; =======================================================================
;; mcarter: 2/18/1999: We need a "point-stack" to be able to push positions
;;   onto and pop them off of.  This way, we can push before jumping to a
;;   tag, and pop to return.  This facilitates tracing deeply through code.

(defvar point-stack nil
  "A list of positions, accessed by push-point and pop-point."
)

(defun push-point ()
  "Push point onto the point stack.
Restore pre-call state by calling pop-point."
  (interactive) ; no args
  (setq point-stack (cons (point-marker) point-stack))
)

(defun pop-point ()
  "Pop a position off the point stack, and make that point.
This undoes what push-point does."
  (interactive) ; no args
  (if (null point-stack)
      (error "Point stack is empty.")
    (let ((new-pos (car point-stack)))
      (setq point-stack (cdr point-stack))
      (switch-to-buffer (marker-buffer new-pos))
      (goto-char new-pos)
    )
  )
)

(global-set-key "\C-cpu" 'push-point)
(global-set-key "\C-cpo" 'pop-point)

; Now, extend that by allowing you to push and chase a tag in one step.
; (Note that the "go back to previously found tag" feature of etags is
;  insufficient for my purposes, because it only lets you go back to where
;  you jumped to, not where you jumped from.)

(defun find-tag-use-default ()
  "Like `find-tag', but automatically use the default tag so that the user
isn't prompted for a tag to use."
  (interactive) ; no args
  (find-tag (funcall (or find-tag-default-function
                         (get major-mode 'find-tag-default-function)
                         'find-tag-default)))
)

(defun push-point-chase-tag ()
  "Calls push-point then find-tag.  This allows you to return to where you
jumped from after looking at where the tag points to.  This facilitates
tracing deeply into code.  It's like following a hyperlink, which you can
go back through with pop-point."
  (interactive) ; no args
  (push-point)
  (command-execute 'find-tag-use-default)
)

(global-set-key "\C-cl" 'push-point-chase-tag) ; mnemonic: like lynx w/ vi keys
(global-set-key "\C-ch" 'pop-point)            ; mnemonic: like lynx w/ vi keys

;; ============ end point stack code ==============================
