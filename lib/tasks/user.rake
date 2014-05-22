namespace :user do

  desc 'Add new user into system'
  task :add, [:login, :password] => [:environment] do |t, params|
    User.create! params.to_hash
  end
end