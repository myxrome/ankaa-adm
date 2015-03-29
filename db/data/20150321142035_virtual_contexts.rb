class VirtualContexts < SeedMigration::Migration
  def up
    application = VirtualContextType.find_by name: 'Application'
    button = VirtualContextType.find_by name: 'Button'
    orientation = VirtualContextType.find_by name: 'Orientation'
    screen = VirtualContextType.find_by name: 'Screen'
    filter = VirtualContextType.find_by name: 'Filter'

    VirtualContext.find_or_create_by! id: 1 do |context|
      context.update_attributes! name: 'Gliese ver 1.0', description: '', virtual_context_type: application
    end

    VirtualContext.find_or_create_by! id: 2 do |context|
      context.update_attributes! name: 'Upload Screen', description: '', virtual_context_type: screen
    end

    VirtualContext.find_or_create_by! id: 3 do |context|
      context.update_attributes! name: 'Compare Screen', description: '', virtual_context_type: screen
    end

    VirtualContext.find_or_create_by! id: 4 do |context|
      context.update_attributes! name: 'Info Screen', description: '', virtual_context_type: screen
    end

    VirtualContext.find_or_create_by! id: 5 do |context|
      context.update_attributes! name: 'Landscape Orientation', description: '', virtual_context_type: orientation
    end

    VirtualContext.find_or_create_by! id: 6 do |context|
      context.update_attributes! name: 'Portrait Orientation', description: '', virtual_context_type: orientation
    end

    VirtualContext.find_or_create_by! id: 7 do |context|
      context.update_attributes! name: 'Buy Button', description: '', virtual_context_type: button
    end

    VirtualContext.find_or_create_by! id: 8 do |context|
      context.update_attributes! name: 'Info Button', description: '', virtual_context_type: button
    end

    VirtualContext.find_or_create_by! id: 9 do |context|
      context.update_attributes! name: '3 000 Filter', description: '', virtual_context_type: filter
    end

    VirtualContext.find_or_create_by! id: 10 do |context|
      context.update_attributes! name: '5 000 Filter', description: '', virtual_context_type: filter
    end

    VirtualContext.find_or_create_by! id: 11 do |context|
      context.update_attributes! name: '10 000 Filter', description: '', virtual_context_type: filter
    end

    VirtualContext.find_or_create_by! id: 12 do |context|
      context.update_attributes! name: '30 000 Filter', description: '', virtual_context_type: filter
    end

  end

  def down
    VirtualContext.where(id: 1..12).each do |v|
      v.delete
    end
  end
end
