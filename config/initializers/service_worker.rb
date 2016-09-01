Rails.application.configure do
  config.serviceworker.routes.draw do
    match "/service_worker.js"
  end
end
