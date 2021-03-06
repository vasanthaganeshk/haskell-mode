;;; inferior-haskell-tests.el --- tests for collapse module  -*- lexical-binding: t -*-

;; Copyright © 2017 Vasantha Ganesh K. <vasanthaganesh.k@tuta.io>

;; This file is not part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.


(require 'ert)
(require 'inf-haskell)
(require 'cl-lib)

(defun haskell-str-chomp (str)
  "Chomp leading and tailing whitespace from STR."
  (while (string-match "\\`\n+\\|^\\s-+\\|\\s-+$\\|\n+\\'"
                       str)
    (setq str (replace-match "" t t str)))
  str)

(defun haskell-split-to-lines (str)
  (cl-mapcar #'haskell-str-chomp (split-string str "\n")))

(ert-deftest test-run-haskell ()
  (run-haskell)
  (should (equal (haskell-split-to-lines (inferior-haskell-get-result "1 + 1"))
              '("Prelude> 1 + 1" "2"))))

(ert-deftest test-inferior-haskell-buffer ()
  "Check if the inferior haskell buffer has been started"
  (run-haskell)
  (should (buffer-live-p inferior-haskell-buffer)))

(ert-deftest test-inferior-haskell-root-dir ()
  "Check if the root dir of the loaded file/project is not nil
This way we test is the file is loaded or not"
  (run-haskell)
  (should (file-directory-p inferior-haskell-root-dir)))
