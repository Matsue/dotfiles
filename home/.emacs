(setq load-path(cons"~/.emacs.d/src" load-path))

;; load $PATH to emacs
(when (memq window-system '(mac ns))
  (let ((envs '("PATH")))
    (exec-path-from-shell-copy-envs envs))
)

;;
;; MELPA
;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;;
;; helm
;;
(require 'helm-config)
(require 'helm-ag)
(require 'helm-command)
(require 'helm-descbinds)
;;(require 'helm-rb)

(setq helm-idle-delay             0.3
      helm-input-idle-delay       0.3
      helm-candidate-number-limit 200)

;;(setq helm-ag-base-command "ag --nocolor --nogroup --ignore-case")
;;(setq helm-ag-thing-at-point 'symbol)

(let ((key-and-func
       `((,(kbd "C-r")   helm-for-files)
         (,(kbd "C-^")   helm-c-apropos)
         (,(kbd "C-;")   helm-resume)
         (,(kbd "M-s")   helm-occur)
         (,(kbd "M-x")   helm-M-x)
         (,(kbd "M-y")   helm-show-kill-ring)
         (,(kbd "M-z")   helm-do-grep)
         (,(kbd "C-S-h") helm-descbinds)
        )))
  (loop for (key func) in key-and-func
        do (global-set-key key func)))

;;
;; migemo
;;
(when (and (executable-find "cmigemo")
           (require 'migemo nil t))
  ;; for mac
  (setq migemo-command "/usr/local/bin/cmigemo")
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  ;; for linux
  ;;(setq migemo-command "cmigemo")
  ;;(setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")

  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (load-library "migemo")
  (migemo-init)

  ;; for helm-migemo
  (require 'helm-migemo)
  (setq helm-use-migemo t)
)

;;
;; shell-pop
;;
(require 'shell-pop)

;; multi-term
;;(add-to-list 'shell-pop-internal-mode-list '("multi-term" "*terminal<1>*" '(lambda () (multi-term))))
;;(shell-pop-set-internal-mode "multi-term")

;; heigth settings
;;(shell-pop-set-window-height 25)
;;(shell-pop-set-internal-mode-shell shell-file-name)

(global-set-key "\C-t" 'shell-pop)

;;
;; Cua-mode
;;
;;(cua-mode t)
;;(setq cua-enable-cua-keys nil)

;;
;; Erlang
;;
(require 'erlang-start)

;;
;; dmacro
;;
(defconst *dmacro-key* "\C-\\" "repeat action key")
(global-set-key *dmacro-key* 'dmacro-exec)
(autoload 'dmacro-exec "dmacro" nil t)

;;
;; compile
;;
(global-set-key "\C-cc" 'compile)

;;
;; rotate
;;
(require 'rotate)
(global-set-key (kbd "C-x t") 'rotate-layout)
(global-set-key (kbd "C-x w") 'rotate-window)

;;
;; dash-at-point
;;
(add-to-list 'load-path "/path/to/dash-at-point")
(autoload 'dash-at-point "dash-at-point"
  "Search the word at point with Dash." t nil)
(global-set-key "\C-cd" 'dash-at-point)

;;
;; ruby-end
;;
;;(require 'ruby-end)

;;
;; JS
;;
(setq js-indent-level 2)

;;
;; web-mode
;;
(require 'web-mode)

;; for under 23 of emacs
(when (< emacs-major-version 24)
  (defalias 'prog-mode 'fundamental-mode))

;; specify extension
(add-to-list 'auto-mode-alist '("\\.phtml$"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x$"   . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?$"     . web-mode))

;; indent
(defun web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-html-offset   2)
  (setq web-mode-css-offset    2)
  (setq web-mode-script-offset 2)
  (setq web-mode-php-offset    2)
  (setq web-mode-java-offset   2)
  (setq web-mode-asp-offset    2))
(add-hook 'web-mode-hook 'web-mode-hook)

;;
;; scss-mode
;;
(require 'scss-mode)
(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))

;; change indent size to 2
;; disable auto-compile to use "compass watch"
(defun scss-custom ()
  "scss-mode-hook"
  (and
   (set (make-local-variable 'css-indent-offset) 2)
   (set (make-local-variable 'scss-compile-at-save) nil)
   )
  )
(add-hook 'scss-mode-hook
  '(lambda() (scss-custom)))

;;
;; markdown-mode
;;
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))

;;
;; yaml-mode
;;
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;;
;; slim-mode
;;
(require 'slim-mode)
(add-to-list 'auto-mode-alist '("\\.slim$" . slim-mode))

;;
;; php-mode
;;
(require 'php-mode)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(setq php-mode-force-pear t)
(add-hook 'php-mode-hook
          '(lambda () 
             (setq tab-width 2) 
             (setq c-basic-offset 2)
             (setq indent-tabs-mode t)) 
          )
