require 'order/topic_group_ordering'
require 'order/topic_ordering'
require 'order/category_ordering'

TopicGroup.send(:include, TopicGroupOrdering)
TopicGroup.send(:include, AutoOrdering)
Topic.send(:include, TopicOrdering)
Topic.send(:include, AutoOrdering)
Category.send(:include, CategoryOrdering)
Category.send(:include, AutoOrdering)