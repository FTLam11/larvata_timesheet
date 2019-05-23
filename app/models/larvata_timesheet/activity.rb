module LarvataTimesheet
  class Activity < ApplicationRecord
    belongs_to :category, class_name: 'LarvataTimesheet::Activity', optional: true
  end
end
