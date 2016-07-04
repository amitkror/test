# == Schema Information
#
# Table name: glossary_imports
#
#  id              :integer         not null, primary key
#  attachment_uid  :string(255)
#  attachment_name :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#


require 'csv'

class GlossaryImport < ActiveRecord::Base

  file_accessor :attachment

  attr_accessible :attachment, :retained_attachment

  validates :attachment_name, presence: true

  def process_import
    errs = ["------ ", "Process import  #{attachment.path}"]
    idx = 0
    open(self.attachment.path) do |f|
      f.each_line do |line|
        idx = idx + 1
        puts idx
        #begin
          CSV.parse(line) do |row|
            begin
              self.process_row(row)
            rescue Exception => ex
              errs << "PROCESS ERROR #{idx} #{row[0]} => #{ex.message} "
            end
          end
        #rescue Exception => e
        #  puts "--ERROR #{idx} #{e.message} #{line}"
        #end
      end
    end
    log errs
    self.destroy
  end

  def process_row(row)
    #puts "PROCESS ROW"
    return "" if row[0].blank?
    h = {
      name: row[0].strip,
      definition: row[1].blank? ? "TBD." : row[1].strip,
      url: row[2].blank? ? "" : row[2].strip,
    }
    glossary = GlossaryTerm.find_by_name(h[:name])
    errs = ["Process row #{h[:name]}"]

    if glossary.blank?
      glossary = GlossaryTerm.new(h)
      unless glossary.save
        if glossary.errors.any?
          glossary.errors.full_messages.each do |msg|
            errs << msg
          end
        end
      end
    else
      glossary.update_attributes(h)
    end
    log errs
    #puts h.to_yaml
  end

  def log(errs)
    errs.each do |err|
      logger.error err
    end

    File.open(File.join(Rails.root.to_s, 'log', 'gimport.log'), 'a') {|f|
      f.write("--")
      errs.each do |err|
        f.write("#{err}\n")
      end
    }
  end
end
