require 'order/topic_group_ordering'
require 'order/topic_ordering'
require 'order/category_ordering'

TopicGroup.send(:include, TopicGroupOrdering)
Topic.send(:include, TopicOrdering)
Category.send(:include, CategoryOrdering)