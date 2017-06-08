class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_welcome
  before_action :prepare_meta_tags, if: "request.get?"

  def prepare_meta_tags(options={})
    site_name   = "East Kin's Universe"
    title       = "Nashville Rock and Roll"
    description = "A rock band from Nashville with a
        website that is informative and fun.  Detroy the universe or bring it new
        life. Good guy or bad guy"
    image       = options[:image] || view_context.image_url("east-kin-radio-cafe")
    current_url = request.url

    # Prepare set of defaults
    defaults = {
      site:        site_name,
      title:       title,
      image:       image,
      description: description,
      twitter: {
        site_name: site_name,
        site: '@eastkin',
        card: 'summary_large_image',
        description: description,
        image: image
      },
      og: {
        url: current_url,
        site_name: site_name,
        title: title,
        image: image,
        description: description,
        type: 'website'
      }
    }
    options.reverse_merge!(defaults)
    set_meta_tags options
  end
  def set_welcome
    @welcome = Welcome.find(1)
  end
end
