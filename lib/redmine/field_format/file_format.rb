require_dependency 'redmine/field_format'

module Redmine
  module FieldFormat
    class FileFormat < Base
      unloadable

      add 'file'
      self.form_partial = 'custom_fields/formats/file'

      def formatted_value(view, custom_field, value, customized = nil, html = false, link = true)
        uploader = self.class.uploader_for(custom_field, customized, value)

        if html
          if link
            view.link_to value.to_s, uploader.url
          else
            value.to_s            
          end
        else
          value.to_s
        end
      end

      def edit_tag(view, tag_id, tag_name, custom_value, options={})
        file_link = (view.link_to(custom_value.value, custom_value.file_url) + view.tag(:br) if custom_value.value) || ''

        view.file_field_tag(tag_name, options.merge(:id => tag_id)) + 
          file_link + 
          remove_tag(view, tag_id, tag_name, custom_value)
      end

      def bulk_edit_tag(view, tag_id, tag_name, custom_field, objects, value, options={})
        raise "Bulk editing of 'file' custom value not supported yet! FileFormat\#bulk_edit_tag needs to be implemented first."
      end

      def remove_tag(view, tag_id, tag_name, custom_value)
        view.content_tag(:label) do
          view.check_box_tag(tag_name, "_delete") + I18n.t(:remove_existing_file)
        end if custom_value.value
      end

      def self.uploader_for(custom_field, customized, value)
        uploader = EspeoFileImageCustomField::ImageUploader.new(customized, "custom_field-#{custom_field.id}")
        uploader.retrieve_from_store!(value) if value
        uploader
      end
    end
  end
end
