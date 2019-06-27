;; ----- undo-tree ----- ;;
(global-undo-tree-mode t)                       ;; undo-tree を起動時に有効にする
(global-set-key (kbd "M-/") 'undo-tree-redo)    ;; M-/ をredo に設定する。


;; ----- Auto Complete ----- ;;
(require 'auto-complete-config)                 ;; auto-complete-config の設定ファイルを読み込む。
(ac-config-default)
(ac-set-trigger-key "TAB")                      ;; TABキーで自動補完を有効にする
(global-auto-complete-mode t)                   ;; TABキーで自動補完を有効にする
