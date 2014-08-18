namespace :virtual_context_type do

  desc 'Init virtual context types into the system'
  task :init => :environment do
    VirtualContextType.create! name: 'Application'
    VirtualContextType.create! name: 'Button'
  end
end