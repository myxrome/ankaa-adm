class EventTypes < SeedMigration::Migration
  def up
    EventType.find_or_create_by! name: 'Unknown'
    EventType.find_or_create_by! name: 'Counter'
    EventType.find_or_create_by! name: 'Timer'
  end

  def down
    EventType.where(name: ['Unknown', 'Counter', 'Timer']).each do |e|
      e.delete
    end
  end
end
