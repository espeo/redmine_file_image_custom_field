require_dependency 'redmine/field_format/file_format'

module Redmine
  module FieldFormat
    class ImageFormat < FileFormat
      add 'image'
      self.form_partial = 'custom_fields/formats/image'

      def formatted_value(view, custom_field, value, customized=nil, html=false)
        if html
          view.image_tag value.to_s
        else
          value.to_s
        end
      end

      def edit_tag(view, tag_id, tag_name, custom_value, options={})
        view.file_field_tag(tag_name, options.merge(:id => tag_id)) + view.image_tag(custom_value.file_thumb_url)
      end
    end
  end
end
