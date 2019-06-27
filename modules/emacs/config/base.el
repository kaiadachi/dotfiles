;; ロックファイル / バックアップファイルを作成しない
(setq create-lockfiles nil)
(setq make-backup-files nil)
(setq auto-save-default nil)

;; 対応するカッコを強調表示
(show-paren-mode t)

;; 時間も表示させる。
(display-time)

;; 行番号を常に表示させる
(global-linum-mode)
(setq linum-format "%4d ")

;; 現在行を目立たせる
(setq hl-line-face 'underline)
(global-hl-line-mode)
