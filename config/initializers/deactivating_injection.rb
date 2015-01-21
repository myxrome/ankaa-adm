TopicGroup.send(:include, AutoDeactivating)
Topic.send(:include, AutoDeactivating)
Category.send(:include, AutoDeactivating)
Value.send(:include, AutoDeactivating)