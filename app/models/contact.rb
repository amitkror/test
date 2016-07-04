# == Schema Information
#
# Table name: contacts
#
#  name    :string
#  email   :string
#  message :text
#  ppc_id  :integer
#

class Contact < ActiveRecord::Base
 
  def self.columns() @columns ||= []; end
 
  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end

  attr_accessible  :name, :email, :message, :ppc_id

  column :name, :string
  column :email, :string
  column :message, :text
  column :ppc_id, :integer

  def save(validate = true)
    validate ? valid? : true
  end
end
   
