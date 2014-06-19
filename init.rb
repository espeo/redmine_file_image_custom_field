require 'redmine/field_format/file_format'
require 'redmine/field_format/image_format'
require 'uploaders/image_uploader'

require 'acts_as_customizable_patch'
require 'models/custom_field_value_patch'

Redmine::Plugin.register :espeo_file_image_custom_field do
  name 'Espeo File Image Custom Field plugin'
  author 'espeo@jtom.me'
  description 'This is a plugin for Redmine'
  version '1.0.0'
  url 'http://espeo.pl'
  author_url 'http://jtom.me'
end
