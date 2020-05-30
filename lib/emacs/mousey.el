;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Change the way the mouse behaves, more like I want it.

;; with these two functions, a drag of mouse-1 marks the region
;; dynamically, mouse-2 inserts the region at the current point,
;; rather than where the mouse is pointing, and mouse-3 kills the
;; marked region.

;;; From: raible@nas.nasa.gov (Eric Raible)
;;; Newsgroups: gnu.emacs.sources
;;; Subject: dynamic highlighting
;;; Date: 8 Jun 93 04:31:50 GMT

(define-key global-map [down-mouse-1] 'mouse-drag-region-dynamically)

(defun mouse-drag-region-dynamically (click)
  "Set the region to the text that the mouse is dragged over.
This must be bound to a button-down mouse event.
It is a compatible replacement for mouse-drag-region, and
acts like a first call to mouse-save-then-kill."
  (interactive "e")
  (mouse-set-point click)
  (push-mark () 'nomsg 'start-highlighting)
  (let ((my-window (posn-window (event-start click))))
    (track-mouse
      (while
          (let ((event (read-event)))
            (cond ((eq (car-safe event) 'mouse-movement)
                   (if (eq (posn-window (event-start event)) my-window)
                       (mouse-set-point event))
                   'continue-looping)))))
    (exchange-point-and-mark)
    (cond ((= (mark) (point))    ;; No dragging - restore the mark
           (pop-mark)
           (setq deactivate-mark t))
          (t      ;; Emulate first click in mouse-save-then-kill
           (copy-region-as-kill (point) (mark))
           (setq mouse-save-then-kill-posn
                 (list (car kill-ring) (point) (mark)))))))

(global-set-key [mouse-2] 'mouse-yank-at-point)

;; the following is based on mouse-yank-at-click from mouse.el
(defun mouse-yank-at-point (click arg)
  "Insert the last stretch of killed text at the current point.
Prefix arguments are interpreted as with \\[yank]."
  (interactive "e\nP")
  (yank arg))

