class ChildrenTopicGroup < SeedMigration::Migration
  def up
    TopicGroup.find_or_create_by! key: '644827f93d7d92ccf25cf56fd63f3d42' do |topic_group|
      topic_group.update_attributes! order: 2, name: 'Детям', active: false
    end
  end

  def down
    TopicGroup.find_by(key: '009980d31a1931b2f6b363d8fdd36bba').each do |t|
      t.delete
    end

  end
end
