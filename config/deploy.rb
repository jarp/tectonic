# config valid only for Capistrano 3.1
lock '3.4.1'

set :application, 'tectonic'
set :stages, %w(production staging vagrant)
set :default_stage, "staging"

set :repo_url, 'git@github.com:ndwebgroup/find-app.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
 set :deploy_to, '/apps/tectonic'

 set :repo_url, 'git@github.com:j-arp/tectonic.git' # Edit this to match your repository
 set :branch, :master
 set :deploy_to, '/apps/tectonic'
 set :pty, true
 set :linked_files, %w{config/database.yml config/application.yml}
 set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
 set :keep_releases, 5
 set :rvm_type, :user
 set :rvm_ruby_version,'ruby-2.2.4' # Edit this if you are using MRI Ruby

 set :puma_rackup, -> { File.join(current_path, 'config.ru') }
 set :puma_state, "#{shared_path}/tmp/pids/puma.state"
 set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
 set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
 set :puma_conf, "#{shared_path}/puma.rb"
 set :puma_access_log, "#{shared_path}/log/puma_error.log"
 set :puma_error_log, "#{shared_path}/log/puma_access.log"
 set :puma_role, :app
 set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
 set :puma_threads, [0, 8]
 set :puma_workers, 0
 set :puma_worker_timeout, nil
 set :puma_init_active_record, true
 set :puma_preload_app, false
