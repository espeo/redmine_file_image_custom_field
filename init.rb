require 'redmine/field_format/file_format'
require 'redmine/field_format/image_format'

require 'espeo_file_image_custom_field/image_uploader'
require 'espeo_file_image_custom_field/patches/acts_as_customizable_patch'
require 'espeo_file_image_custom_field/patches/custom_field_value_patch'

Redmine::Plugin.register :espeo_file_image_custom_field do
  name 'File & Image CustomField plugin'
  author 'espeo@jtom.me'
  description 'Adds 2 additional types for custom fields you can create: a file and an image.'
  version '1.0.0'
  url 'http://espeo.pl'
  author_url 'http://jtom.me'
end
