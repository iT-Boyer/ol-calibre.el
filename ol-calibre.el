;;; config/kvb74-org/ol-calibre.el -*- lexical-binding: t; -*-

;;; ol-calibre.el - Support for links to calibre libreary in Org mode
(require 'ol)

(org-link-set-parameters "calibre"
                         :follow #'org-calibre-open
                         :export #'org-calibre-export
                         )

(defcustom org-calibre-command "calibre"
  "The Emacs command to be used to display a calibre query."
  :group 'org-link
  :type '(string)) 

(defun org-calibre-open (query)
  "QUERY should be a string querying in Calibre search."
  (async-start-process "Calibre" org-calibre-command nil (format "calibre://search/book?q=%s" query)))

(defun org-calibre-export (link description format _)
  "Export a calibre page link from Org files."
  (let ((path (format "http://man.he.net/?topic=%s&section=all" link))
        (desc (or description link)))
    (pcase format
      (`html (format "<a target=\"_blank\" href=\"%s\">%s</a>" path desc))
      (`latex (format "\\href{%s}{%s}" path desc))
      (`texinfo (format "@uref{%s,%s}" path desc))
      (`ascii (format "%s (%s)" desc path))
      (`t path))))

(provide 'ol-calibre)
;;; ol-calibre.el ends here
