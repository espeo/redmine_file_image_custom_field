# File & Image Custom Fields

### A redmine plugin by Espeo Software.

Adds 2 additional types for custom fields you can create: a file and an image.

Adds ImageField and FileField to CustomField types.

## Requirements

1. **imagemagick** installed

  You can install it just like this:
  ```sh
  sudo apt-get install -y imagemagick
  # or on mac
  brew install imagemagick
  ```

### Installation

1. Make sure your redmine installation already meets the above *requirements*.

2. Copy this plugin's contents or check out this repository into `/redmine/plugins/espeo_file_image_custom_field` directory.

## Notes

This plugin replaces following redmine files (because to make this plugin work, we need to change some hardcoded templates):

- `app/views/projects/_edit.html.erb`
- `app/views/projects/new.html.erb`
- `app/views/users/_general.html.erb`

This may cause some inconsistensy when Redmine gets updated or another plugin would want to replace this template.
