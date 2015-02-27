require_dependency 'redmine/field_format'

module Redmine
  module FieldFormat
    class RelationFormat < Base
      unloadable

      add 'relation'
      self.form_partial = 'custom_fields/formats/relation'
      self.multiple_supported = true
      field_attributes :relation_type

      def formatted_value(view, custom_field, value, customized = nil, html = false, link = true)
        relation_item = self.relation_item(custom_field, value)
        return if relation_item.nil?

        if html
          if link
            view.link_to relation_item.name, relation_item
          else
            relation_item.name
          end
        else
          relation_item.name
        end
      end

      def edit_tag(view, tag_id, tag_name, custom_value, options={})
        blank_option = ''.html_safe
        unless custom_value.custom_field.multiple?
          if custom_value.custom_field.is_required?
            unless custom_value.custom_field.default_value.present?
              blank_option = view.content_tag('option', "--- #{l(:actionview_instancetag_blank_option)} ---", :value => '')
            end
          else
            blank_option = view.content_tag('option', '&nbsp;'.html_safe, :value => '')
          end
        end

        records = relation_visible_records(custom_value.custom_field)
        options_tags = blank_option + view.options_for_select(records.map do |record|
          [record.name, record.id]
        end, custom_value.value)
        s = view.select_tag(tag_name, options_tags, options.merge(:id => tag_id, :multiple => custom_value.custom_field.multiple?))
        if custom_value.custom_field.multiple?
          s << view.hidden_field_tag(tag_name, '')
        end
        s
      end

      def relation_class(custom_field)
        custom_field.format_store[:relation_type].classify.constantize
      end

      def relation_item(custom_field, value)
        relation_class(custom_field).find_by_id(value)
      end

      def relation_visible_records(custom_field)
        relation_class(custom_field).visible
      end
    end
  end
end
