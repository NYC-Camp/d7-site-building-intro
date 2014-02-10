; $Id$
; Core version; ------------
core = 7.x

; API version; ------------
api = 2

; Core project; ------------
projects[] = drupal

; Modules; --------
projects[] = admin
projects[] = advanced_help
projects[] = ckeditor
projects[] = ctools
projects[] = date
projects[] = demo
projects[] = devel
projects[] = ds
projects[] = entity
projects[] = field_collection
projects[] = module_filter
projects[] = pathauto
projects[] = views

; Themes; --------
projects[] = fusion

; Libraries; --------
libraries[ckeditor][download][type]= "get"
libraries[ckeditor][download][url] = "http://download.cksource.com/CKEditor/CKEditor/CKEditor%203.6.4/ckeditor_3.6.4.zip"
libraries[ckeditor][directory_name] = "ckeditor"
libraries[ckeditor][destination] = "libraries"

; Files; --------
; Demo
libraries[demo_images][download][type] = "get"
libraries[demo_images][download][url] = "https://dl.dropbox.com/s/jp82q758nr4ruh4/demo.zip?dl=1"
libraries[demo_images][destination] = "../default/files"
; Images
libraries[demo][download][type] = "get"
libraries[demo][download][url] = "https://dl.dropbox.com/s/aunh9rqgdxce0si/images.zip?dl=1"
libraries[demo][destination] = "../default/private-files"