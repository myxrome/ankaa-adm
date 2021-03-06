class VirtualContextTypes < SeedMigration::Migration
  def up
    VirtualContextType.find_or_create_by! name: 'Application'
    VirtualContextType.find_or_create_by! name: 'Button'
    VirtualContextType.find_or_create_by! name: 'Orientation'
    VirtualContextType.find_or_create_by! name: 'Screen'
    VirtualContextType.find_or_create_by! name: 'Filter'
  end

  def down
    VirtualContextType.where(name: ['Application', 'Button', 'Orientation', 'Screen', 'Filter']).each do |v|
      v.delete
    end
  end
end
