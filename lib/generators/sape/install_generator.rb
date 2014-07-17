require 'rails/generators'

module Sape
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path("../../../", __FILE__)
    desc "This generator installs Sape to Asset Pipeline"

    def add_assets
      template('app/assets/stylesheets/sape.css', 'app/assets/stylesheets/sape.css')
    end

  end
end