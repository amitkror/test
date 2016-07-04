# == Schema Information
#
# Table name: resource_imports
#
#  id              :integer         not null, primary key
#  attachment_uid  :string(255)
#  attachment_name :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

require 'csv'

class ResourceImport < ActiveRecord::Base

  file_accessor :attachment

  # Setup accessible (or protected) attributes for your model
  attr_accessible :attachment, :retained_attachment

  validates :attachment_name, presence: true

  def process_import
    #puts "PROCESS IMPORT #{attachment.path}"
    errs = ["------ ", "Process import  #{attachment.path}"]
    idx = 0
    open(self.attachment.path) do |f|
      f.each_line do |line|
        idx = idx + 1
        logger.error idx
        begin
          CSV.parse(line) do |row|
            self.process_row(row)
          end
        rescue Exception => e
          errs << "ERROR #{idx} #{e.message}"
        end
      end
    end
    log errs
    self.destroy
  end

  def process_row(row)
    #puts "PROCESS ROW"
    org = get_organization(row[53])

    h = {
      name: row[0].blank? ? "" : row[0].strip,
      type_id: get_type(row),
      teaser: row[2].blank? ? "" : row[2].strip,
      body: row[3].blank? ? "" : row[3].strip,
      website: row[5].blank? ? "" : row[5].strip,
      phase_ids: get_phases(row),
      audience_ids: get_audiences(row),
      subject_ids: get_subjects(row),
      language_ids: get_languages(row),
      conditions_of_use_id: get_conditions_of_use(row),
      organization_id: (org.blank? ? nil : org.id),
      state: "", # we're not importing addresses now.
      status_id: 2,
    }
    resource = Resource.find_by_name(h[:name])
    errs = ["Saving #{h[:name]}"]

    if resource.blank?
      resource = Resource.new(h)
    else
      errs << h.to_yaml
      resource.update_attributes(h)
    end

    unless resource.save
      if resource.errors.any?
        resource.errors.full_messages.each do |msg|
          errs << msg
        end
      end
    end

    log errs

  end

  def get_audiences(row)
    audiences = []
    audiences << 4 if cell_to_boolean row[15] #HS
    audiences << 3 if cell_to_boolean row[16] #GED
    audiences << 2 if cell_to_boolean row[17] #College
    audiences << 1 if cell_to_boolean row[18] #Adviser
    audiences << 5 if cell_to_boolean row[19] #Parent
    audiences << 7 if cell_to_boolean row[20] #Immigrant
    audiences << 8 if cell_to_boolean row[21] #Disability
    audiences << 9 if cell_to_boolean row[22] #Foster
    audiences << 6 if cell_to_boolean row[23] #FirstGen
    audiences
  end

  def get_conditions_of_use(row)
    return 1 if cell_to_boolean row[44] #no strings
    return 2 if cell_to_boolean row[45] #remix
    return 3 if cell_to_boolean row[46] #share
    return 4 if cell_to_boolean row[47] #fine print
    nil
  end

  def get_languages(row)
    languages = []
    #languages << 1 if cell_to_boolean row[33] #english
    languages << 1 if cell_to_boolean row[34] #arabic
    languages << 2 if cell_to_boolean row[35] #bengali
    languages << 3 if cell_to_boolean row[36] #chinese
    languages << 4 if cell_to_boolean row[37] #french
    languages << 5 if cell_to_boolean row[38] #haitian
    languages << 6 if cell_to_boolean row[39] #korean
    languages << 7 if cell_to_boolean row[40] #russian
    languages << 8 if cell_to_boolean row[41] #spanish
    languages << 9 if cell_to_boolean row[42] #urdu
    languages << 10 if cell_to_boolean row[43] #other
    languages
  end

  def get_organization(value)
    return nil if value.blank?
    Organization.find_or_create_by_name(value)
  end

  def get_phases(row)
    phases = []
    phases << 1 if cell_to_boolean row[6] #explore
    phases << 2 if cell_to_boolean row[7] #apply
    phases << 3 if cell_to_boolean row[8] #pay for college
    phases << 4 if cell_to_boolean row[9] #user your summer
    phases << 5 if cell_to_boolean row[10] #succeed in college
    phases
  end

  def get_subjects(row)
    subjects = []
    subjects << 3 if cell_to_boolean row[24] #advising
    subjects << 4 if cell_to_boolean row[25] #search
    subjects << 5 if cell_to_boolean row[26] #application
    subjects << 2 if cell_to_boolean row[27] #exploration
    subjects << 6 if cell_to_boolean row[28] #FA planning
    subjects << 1 if cell_to_boolean row[29] #tutoring
    subjects << 9 if cell_to_boolean row[30] #life
    subjects << 11 if cell_to_boolean row[31] #finish
    subjects << 8 if cell_to_boolean row[32] #after
    subjects
  end

  def get_type(row)
    return 2 if cell_to_boolean row[11] #website
    return 3 if cell_to_boolean row[12] #video
    return 4 if cell_to_boolean row[13] #tutorial
    return 5 if cell_to_boolean row[14] #document
    1
  end

  def log(errs)
    errs.each do |err|
      logger.error err
    end

    File.open(File.join(Rails.root.to_s, 'log', 'rimport.log'), 'a') {|f|
      f.write("--")
      errs.each do |err|
        f.write("#{err}\n")
      end
    }
  end

  private
    def cell_to_boolean(value)
      return false if value.blank?
      value = value.to_s.strip.downcase
      value == "yes" || value == "1" || value == "x"
    end
end
