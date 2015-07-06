;;; TWEAKS
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(setq inhibit-startup-screen t
      initial-scratch-message nil
      visible-bell t
      ring-bell-function 'ignore)

;; Store backup and autosave files in tmp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(set-face-attribute 'default nil
                    :family "Pragmata Pro" :height 145 :weight 'normal)
(global-hl-line-mode 1) ; Highlight current line
;; (set-face-background 'hl-line "#eeeeee") ; Current line color
(global-linum-mode t) ; Line numbers

(defalias 'yes-or-no-p 'y-or-n-p) ; Yes/no prompts -> y/no
(setq require-final-newline t) ; Require newline at end of file

(setq-default indent-tabs-mode nil) ; Use spaces instead of tabs
(setq-default tab-width 2) ; Set tab width to 2 (spaces)



;;; PACKAGES
(defvar package-list)
(setq package-list '(subatomic-theme
                     evil
                     evil-surround
                     evil-commentary
                     undo-tree
                     smex
                     flycheck
                     expand-region
                     haskell-mode
                     js2-mode))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; Fetch the list of packages available
(or (file-exists-p package-user-dir) (package-refresh-contents))

;; Install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(load-theme 'subatomic t)

;; Evil (and its plugins)
(evil-mode 1)
(setq evil-default-cursor t) ; Fix cursor in color themes
(define-key evil-normal-state-map (kbd ";") 'evil-ex)
(define-key evil-normal-state-map (kbd ":") 'evil-repeat-find-char)
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
(define-key evil-normal-state-map (kbd "H") 'evil-first-non-blank)
(define-key evil-normal-state-map (kbd "L") 'evil-last-non-blank)
(define-key evil-normal-state-map (kbd "Y") 'copy-to-end-of-line)
(define-key evil-normal-state-map (kbd "+") 'er/expand-region)
;; (define-key evil-normal-state-map (kbd "_")    'er/contract-region)
(global-evil-surround-mode 1)
(evil-commentary-mode)

;; Smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                  ; when Smex is auto-initialized on its first run.

;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; haskell-mode
