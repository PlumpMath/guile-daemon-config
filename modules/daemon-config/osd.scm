;;; osd.scm --- Auxiliary code for working with OSDs

;; Copyright © 2016 Alex Kost <alezost@gmail.com>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-module (daemon-config osd)
  #:use-module (xosd)
  #:use-module (al utils)
  #:export (hide-osds
            define-osd))

(define %osds '())

(define-syntax-rule (define-osd name expression)
  "Define NAME thunk that will return OSD object that EXPRESSION evaluates to.
This object will be returned on subsequent calls of NAME.  This object
is also remembered for such procedures as 'hide-osds'."
  (define-delayed name
    (let ((osd expression))
      (push! osd %osds)
      osd)))

(define (hide-osds)
  "Hide all OSDs made with 'define-osd'."
  (for-each hide-osd %osds))

;;; osd.scm ends here
