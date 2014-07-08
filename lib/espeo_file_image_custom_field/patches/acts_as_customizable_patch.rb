require_dependency 'acts_as_customizable'

Rails.application.config.to_prepare do
  Redmine::Acts::Customizable::InstanceMethods.class_eval do
    # We replace this method in order only to:
    # - remove #to_s mapping of the values
    #   (so we can pass the UploadedFile to CustomFieldValue#value)
    def custom_field_values=(values)
      values = values.stringify_keys

      custom_field_values.each do |custom_field_value|
        key = custom_field_value.custom_field_id.to_s
        if values.has_key?(key)
          value = values[key]
          if value.is_a?(Array)
            value = value.reject(&:blank?).uniq
            if value.empty?
              value << ''
            end
          end
          custom_field_value.value = value
        end
      end
      @custom_field_values_changed = true
    end
  end
end
