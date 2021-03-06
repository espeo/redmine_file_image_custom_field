require_dependency 'redmine/field_format/file_format'

module Redmine
  module FieldFormat
    class ImageFormat < FileFormat
      unloadable

      add 'image'
      self.form_partial = 'custom_fields/formats/image'

      def formatted_value(view, custom_field, value, customized = nil, html = false, link = true)
        uploader = self.class.uploader_for(custom_field, customized, value)

        if html
          img = view.image_tag(uploader.versions[:thumb].url || uploader.url)
          if link
            view.link_to img, uploader.url
          else
            img            
          end
        else
          value.to_s
        end
      end

      def edit_tag(view, tag_id, tag_name, custom_value, options={})
        image = (view.link_to(view.image_tag(custom_value.file_thumb_url), custom_value.file_url) + view.tag(:br) if custom_value.value) || ''

        view.file_field_tag(tag_name, options.merge(:id => tag_id)) + 
          image + 
          remove_tag(view, tag_id, tag_name, custom_value)
      end
    end
  end
end
