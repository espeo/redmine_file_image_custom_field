require_dependency 'redmine/field_format'

module Redmine
  module FieldFormat
    class FileFormat < Base
      add 'file'
      self.form_partial = 'custom_fields/formats/file'

      def formatted_value(view, custom_field, value, customized=nil, html=false)
        if html
          if custom_field.url_pattern.present?
            super
          elsif custom_field.text_formatting == 'full'
            view.textilizable(value, :object => customized)
          else
            value.to_s
          end
        else
          value.to_s
        end
      end

      def edit_tag(view, tag_id, tag_name, custom_value, options={})
        custom_value.value + view.file_field_tag(tag_name, options.merge(:id => tag_id))
      end

      def bulk_edit_tag(view, tag_id, tag_name, custom_field, objects, value, options={})
        raise "Bulk editing of 'file' custom value not supported yet! FileFormat\#bulk_edit_tag needs to be implemented first."
      end
    end
  end
end
