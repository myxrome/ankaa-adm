# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'ankaa-adm'
set :repo_url, 'git@bitbucket.org:myxrome/ankaa-adm.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/ankaa-adm'

# Default value for :log_level is :debug
set :log_level, :trace

# Default value for :pty is false
# set :pty, true

set :symlinked_dirs,
    [
        {source: '/mnt/nfs/content', target: "#{shared_path}/public/content"}
    ]

# Default value for :linked_files is []
set :linked_files, %w{config/application.yml config/database.yml config/secrets.yml config/unicorn.rb}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets public/content}

set :uploaded_files,
    [
        {source: 'config/application.yml', target: "#{shared_path}/config/application.yml"},
        {source: 'config/database.yml', target: "#{shared_path}/config/database.yml"},
        {source: 'config/secrets.yml', target: "#{shared_path}/config/secrets.yml"},
        {source: 'config/remote/ankaa-adm.eye', target: '/etc/eye/init.d/ankaa-adm.eye'},
        {source: 'config/remote/unicorn.rb', target: "#{shared_path}/config/unicorn.rb"}
    ]

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :rbenv_type, :system # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.1.4'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

namespace :deploy do

  task :start do
    run "eye start #{application}"
  end

  task :stop do
    run "eye stop #{application}"
  end

  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      run "eye restart #{application}"
    end
  end

  after :finishing, :restart
  before :restart, 'eye:load_eye'

  namespace :symlink do
    before :shared, :create_symlinked_dirs, :create_linked_dirs, :upload_files
  end

  after :migrate, :seed

end
