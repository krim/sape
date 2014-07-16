require "sape/version"

module Sape
  require 'sape/railtie' if defined?(Rails)
  require 'app/helpers/sape_helper'

  path = File.join(File.dirname(__FILE__), 'app', 'models')
  $LOAD_PATH << path

  ActiveSupport::Dependencies.autoload_paths << path
  ActiveSupport::Dependencies.autoload_once_paths.delete(path)
  ActionView::Base.send :include, SapeHelper
  ActionController::Base.prepend_view_path File.join(File.dirname(__FILE__), 'app/views')
end

require 'sape/fetcher.rb'