CustomFieldValue.module_eval do
  def is_file_format?
    custom_field.field_format.in? %w[file image]
  end

  def value=(value)
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
