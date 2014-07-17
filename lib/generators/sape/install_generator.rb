require 'rails/generators'

module Sape
  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path("../../app/assets/stylesheets", __FILE__)
    desc "This generator installs Sape to Asset Pipeline"

    def add_assets
      copy_file 'sape.css', 'app/assets/stylesheets/sape.css'
    end

  end
end