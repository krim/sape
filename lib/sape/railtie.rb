class Sape::Railtie < Rails::Railtie
  rake_tasks do
    load 'tasks/sape.rake'
  end
end