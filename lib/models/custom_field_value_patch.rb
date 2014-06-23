module CustomFieldValuePatch
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
      custom_field.field_format.in? %w[file image]
    end

    def value_with_file=(value)
      @value = value
      if is_file_format?
        if value.is_a? ActionDispatch::Http::UploadedFile
          if uploader.store!(value)
            @value = uploader.filename
          else
            @value = value_was || nil
          end
        end
      end
      @value
    end

    def uploader
      @uploader ||= ImageUploader.new(customized, "custom_field-#{custom_field.id}")
      @uploader.retrieve_from_store!(value) if value
      @uploader
    end

    def file_thumb_url
      uploader.versions[:thumb].url || uploader.url
    end
  end
end

Rails.application.config.to_prepare do
  CustomFieldValue.send :include, CustomFieldValuePatch
end
