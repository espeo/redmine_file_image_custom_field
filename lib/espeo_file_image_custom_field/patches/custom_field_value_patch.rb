module EspeoFileImageCustomField::Patches::CustomFieldValuePatch
  def self.included(base)
    base.extend         ClassMethods
    base.send :include, InstanceMethods

    base.class_eval do
      unloadable

      alias_method_chain :value=, :file
    end
  end
  
  module ClassMethods
  end
  
  module InstanceMethods
    def is_file_format?
      custom_field.field_format.in? %w(file image)
    end

    def value_with_file=(value)
      @value = value
      if is_file_format?
        @value = if value.is_a? ActionDispatch::Http::UploadedFile
          if uploader.store!(value)
            uploader.filename
          else
            value_was || nil
          end
        elsif value == "_delete"
          nil
        else
          @value
        end
      end
      @value
    end

    def uploader
      @uploader ||= Redmine::FieldFormat::ImageFormat.uploader_for(custom_field, customized, value)
    end

    def file_thumb_url
      uploader.versions[:thumb].url || uploader.url
    end
  end
end

Rails.application.config.to_prepare do
  CustomFieldValue.send :include, EspeoFileImageCustomField::Patches::CustomFieldValuePatch
end
