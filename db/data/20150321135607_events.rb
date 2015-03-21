class Events < SeedMigration::Migration
  def up
    counter = EventType.find_by(name: 'Counter')
    timer = EventType.find_by(name: 'Timer')

    Event.find_or_create_by! tag: 'VALUE_CONVERSION_COUNTER' do |event|
      event.update_attributes! name: 'Value Conversion', event_type: counter
    end
    Event.find_or_create_by! tag: 'APPLICATION_START_COUNTER' do |event|
      event.update_attributes! name: 'Application Start', event_type: counter
    end
    Event.find_or_create_by! tag: 'TOPIC_GROUP_VIEW_TIMER' do |event|
      event.update_attributes! name: 'Topic Group Timer', event_type: timer
    end
    Event.find_or_create_by! tag: 'TOPIC_VIEW_TIMER' do |event|
      event.update_attributes! name: 'Topic Timer', event_type: timer
    end
    Event.find_or_create_by! tag: 'CATEGORY_VIEW_TIMER' do |event|
      event.update_attributes! name: 'Category Timer', event_type: timer
    end
    Event.find_or_create_by! tag: 'VALUE_VIEW_TIMER' do |event|
      event.update_attributes! name: 'Value Timer', event_type: timer
    end
    Event.find_or_create_by! tag: 'UPLOAD_SCREEN_TIMER' do |event|
      event.update_attributes! name: 'Upload Screen Timer', event_type: timer
    end
    Event.find_or_create_by! tag: 'COMPARE_SCREEN_TIMER' do |event|
      event.update_attributes! name: 'Compare Screen Timer', event_type: timer
    end
    Event.find_or_create_by! tag: 'INFO_SCREEN_TIMER' do |event|
      event.update_attributes! name: 'Info Screen Timer', event_type: timer
    end
    Event.find_or_create_by! tag: 'ORIENTATION_TIMER' do |event|
      event.update_attributes! name: 'Orientation Timer', event_type: timer
    end
    Event.find_or_create_by! tag: 'VALUE_CLICK_COUNTER' do |event|
      event.update_attributes! name: 'Value Click', event_type: counter
    end
    Event.find_or_create_by! tag: 'BUY_BUTTON_CLICK_COUNTER_COUNTER' do |event|
      event.update_attributes! name: 'Buy Button Click', event_type: counter
    end
    Event.find_or_create_by! tag: 'INFO_BUTTON_CLICK_COUNTER_COUNTER' do |event|
      event.update_attributes! name: 'Info Button Click', event_type: counter
    end
  end

  def down
    Event.where(tag: ['VALUE_CONVERSION_COUNTER', 'APPLICATION_START_COUNTER', 'TOPIC_GROUP_VIEW_TIMER',
                      'TOPIC_VIEW_TIMER', 'CATEGORY_VIEW_TIMER', 'VALUE_VIEW_TIMER', 'UPLOAD_SCREEN_TIMER',
                      'COMPARE_SCREEN_TIMER', 'INFO_SCREEN_TIMER', 'ORIENTATION_TIMER', 'VALUE_CLICK_COUNTER',
                      'BUY_BUTTON_CLICK_COUNTER_COUNTER', 'INFO_BUTTON_CLICK_COUNTER_COUNTER']).each do |e|
      e.delete
    end
  end
end
