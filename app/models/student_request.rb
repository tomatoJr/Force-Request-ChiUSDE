class StudentRequest < ActiveRecord::Base
  
  audited
  # States of the students 
    ACTIVE_STATE = "Active"
    WITHDRAWN_STATE = "Withdraw"
    REJECTED_STATE = "Rejected"
    HOLD_STATE = "Hold"
    APPROVED_STATE = "Approved"
    
    # Priority of the Students
    VERYHIGH_PRIORITY = "Very High"
    HIGH_PRIORITY = "High"
    NORMAL_PRIORITY = "Normal"
    LOW_PRIORITY = "Low"
    VERYLOW_PRIORITY = "Very Low"
    
    Time.zone = 'Central Time (US & Canada)'
    time = Time.zone.now()
        # List Year and Semester
    CURRENT_YEAR = time.strftime("%Y")
    current_year = CURRENT_YEAR.to_i
    CURRENT_MONTH = time.strftime("%m")
    current_month = CURRENT_MONTH.to_i
    next_year = current_year +1;
    
    
    SPRING = current_year.to_s + " Spring"
    FALL = current_year.to_s + " Fall"
    SUMMER = current_year.to_s + " Summer"
    NSPRING = next_year.to_s + " Spring"
    NFALL = next_year.to_s + " Fall"
    NSUMMER = next_year.to_s + " Summer"
    
    
    STATES_AVAILABLE_TO_ADMIN = [StudentRequest::APPROVED_STATE, StudentRequest::REJECTED_STATE, StudentRequest::HOLD_STATE]
    PRIORITY_LIST = [StudentRequest::VERYHIGH_PRIORITY, StudentRequest::HIGH_PRIORITY, StudentRequest::NORMAL_PRIORITY, StudentRequest::LOW_PRIORITY, StudentRequest::VERYLOW_PRIORITY]
    SEMESTER_LIST = [StudentRequest::NSPRING, StudentRequest::NFALL, StudentRequest::NSUMMER,StudentRequest::SPRING, StudentRequest::FALL, StudentRequest::SUMMER]
    
    
    #Classification
    CLASSIFICATION_LIST = ['U1', 'U2', 'U3', 'U4', 'U5', 'G7', 'G8']
    MAJOR_LIST = [      
             'None',    
             'Computer Science', 
             'BA Computing',
             'Computer Engineering (CSCE)',
             'Computer Engineering (ECEN)',
             'Electrical Engineering',
             'Applied Mathematical Sciences',            
            
             'Accounting', 
             'Aerospace Engineering',
             'Agribusiness', 
             'Agricultural Communications & Journalism', 
             'Agricultural Economics', 
             'Agricultural Leadership & Development', 
             'Agricultural Economics', 
             'Agricultural Science', 
             'Allied Health',
             'Animal Science',
             'Anthropology',

             'Biochemistry',
             'Bioenvironmental Sciences (BESC)',
             'Biological & Agricultural Engineering (BAEN)',
             'Biology (BIOL)',
             'Biomedical Engineering (BMEN)',
             'Biomedical Sciences (BIMS)',
             'Chemical Engineering (CHEN)',
             'Chemistry (CHEM)',
             'Civil Engineering (CVEN)',
             'Classics (CLAS)',
             'Communication (COMM)',
             'Community Health',
             'Construction Science (COSC)',
             'Dance Science (DASC)',
             'Ecological Restoration',
             'Economics (ECON)',

             'Electronic Systems Engineering Technology (ESET)',
             'English (ENGL)',
             'Entomology (ENTO)',
             'Environmental Design (ENDS)',
             'Environmental Geosciences',
             'Environmental Studies (Geosciences)',
             'Environmental Studies (Plant Pathology & Microbiology)',
             'Finance (FINC)',
             'Food Science & Technology',
             'Forensic & Investigative Sciences (FIVS)',            
             'Forestry (FRSC)',
             'Genetics (GENE)',
             'Geographic Information Science & Technology',
             'Geography (GEOG)',
             'Geology (GEOL)',
             'Geophysics (GEOP)',
             'History (HIST)',
             'Horticulture',
             'Human Resource Development',
             'Industrial Distribution (IDIS)',
             'Industrial Engineering (ISEN)',
             'Interdisciplinary Studies-Bilingual Education',
             'Interdisciplinary Studies-Early Childhood',
             'Interdisciplinary Studies-Middle Grades English/Language Arts/Social Studies',
             'Interdisciplinary Studies-Middle Grades Math/Science',
             'Interdisciplinary Studies-Special Education',
             'International Studies (INTS)',
             'Kinesiology-Applied Exercise Physiology',
             'Kinesiology-Basic Exercise Physiology',
             'Kinesiology-Motor Behavior',
             'Kinesiology-Physical Education Certification',
             'Landscape Architecture (LAND)',
             'Management (MGMT)',
             'Management Information Systems (MIS)',
             'Manufacturing & Mechanical Engineering Technology',
             'Marine Biology (MARB)',
             'Marine Engineering Technology (MARE)',
             'Marine Fisheries',
             'Marine Sciences (MARS)',
             'Marine Transportation (MART)',
             'Maritime Administration (MARA)',
             'Maritime Studies (MAST)',
             'Marketing (MKTG)',
             'Materials Science & Engineering (MSEN)',
             'Mathematics (MATH)',
             'Mechanical Engineering (MEEN)',
             'Meteorology (METR)',
             'Microbiology (MICR)',
             'Modern Languages (MODL)',
             'Molecular & Cell Biology',
             'Multidisciplinary Engineering Technology (MXET)',
             'Nuclear Engineering (NUEN)',
             'Nutritional Sciences (NFSC)',
             'Ocean and Coastal Resources (OCRE)',
             'Ocean Engineering (OCEN)',
             'Oceanography (OCNG)',
             'Offshore and Coastal Systems Engineering',
             'Performance Studies (PERF)',
             'Petroleum Engineering (PETE)',
             'Philosophy (PHIL)',
             'Plant & Environmental Soil Science',
             'Political Science (POLS)',
             'Poultry Science (POSC)',
             'Psychology (PSYC)',
             'Public Health (PHLT)',            
             'Rangeland Ecology & Management (RLEM)',            
             'Recreation, Park & Tourism Sciences (RPTS)',            
             'Renewable Natural Resources (RENR)',
             'School Health',
             'Sociology (SOCI)',
             'Spanish (SPAN)',
             'Spatial Sciences (SPSC)',
             'Sport Management (SPMT)',
             'Statistics (STAT)',
             'Supply Chain Management (SCMT)',
             'Technology Management (TCMG)',
             'Telecommunication Media Studies',
             'Turfgrass Science',
             'University Studies - Architecture',
             'University Studies - Child Professional Services',
             'University Studies - Dance',
             'University Studies - Environmental Business',
             'University Studies - Geography',
             'University Studies - GIS & Technology',
             'University Studies - Journalism',
             'University Studies - Leadership',
             'University Studies - Marine Environmental Law & Policy',
             'University Studies - Oceans and One Health',
             'University Studies - Race, Gender & Ethnicity',
             'University Studies - Religious Thought, Practices & Cultures',
             'University Studies - Society, Ethics & Law',
             'Urban & Regional Planning (URPN)',
             'Visualization',
             'Wildlife & Fisheries Sciences (WFSC)',
             'Women\'s and Gender Studies (WGST)',
             'Zoology (ZOOL)',           
             'Others']
    # time = Time.new

    

    
    LIST_YEAR = []
    for i in current_year..current_year+100
      LIST_YEAR << i.to_s
    end
    
    LIST_SEMESTER = ['Spring', 'Fall', 'Summer']
    
    YEAR_SEMESTER = []
    LIST_YEAR.each do |year|
      LIST_SEMESTER.each do |semester|
        if year.to_i == current_year and current_month <= 4
          YEAR_SEMESTER << year + " " + semester
        elsif year.to_i == current_year and current_month <= 8 and semester != "Spring"
          YEAR_SEMESTER << year + " " + semester
        elsif semester == "Fall"
          YEAR_SEMESTER << year + " " + semester
        elsif year.to_i != current_year
          YEAR_SEMESTER << year + " " + semester
        end
      end
    end
    
    REQUEST_SEMESTER = []
    for i in current_year..current_year+1
      LIST_SEMESTER.each do |semester|
        if i == current_year and current_month <= 4
          REQUEST_SEMESTER << i.to_s + " " + semester
        elsif i == current_year and current_month <= 8 and semester != "Spring"
          REQUEST_SEMESTER << i.to_s + " " + semester
        elsif semester == "Fall"
          REQUEST_SEMESTER << i.to_s + " " + semester
        elsif i != current_year
          REQUEST_SEMESTER << i.to_s + " " + semester
        end
      end
    end
    
    self.primary_key = "request_id"
    validates :uin, presence: true
    validates :name, presence: true
    validates_format_of :name, :with => /^[^0-9`!@#\$%\^&*+_=]+$/, :multiline => true
    validates :major, presence: true
    validates :classification, presence: true
    validates :email, presence: true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validates :request_semester, presence: true
    validates :course_id, presence: true
    validates_format_of :course_id, :with => /^\d+$/, :multiline => true
    validates_format_of :section_id, :with => /^\d*$/, :multiline => true
    # validates_format_of :phone, :with => /1?\s*\W?\s*([2-9][0-8][0-9])\s*\W?\s*([2-9][0-9]{2})\s*\W?\s*([0-9]{4})(\se?x?t?(\d*))?/
    #validates :classification, inclusion: { in: CLASSIFICATION_LIST, 
    #  message: "%{value} is not a valid classification" }
    validates :request_semester, inclusion: { in: YEAR_SEMESTER, 
      message: "%{value} is not a valid request semester" }
    validates :priority, inclusion: {in: PRIORITY_LIST,
      message: "%{value} is not a valid prioroty"}
      
    attr_encrypted :course_id, key: ENV['COURSE_KEY'].truncate(32)
    attr_encrypted :section_id, key: ENV['SECTION_KEY'].truncate(32)
    
    before_create :create_request_id
    before_save :update_time
    
    before_create :set_creation_date
  
    def set_creation_date
      # self.creation_date = DateTime.now()
      Time.zone = 'Central Time (US & Canada)'
      self.creation_date = Time.zone.now()
    end

    def update_time
      # self.last_updated = DateTime.now()
      Time.zone = 'Central Time (US & Canada)'
      self.last_updated = Time.zone.now()
    end
    
    def create_request_id
      begin
        self. request_id = "FRS" + SecureRandom.hex(10)
      end while self.class.exists?(:request_id => request_id)
    end
    
    def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |student_request|
          csv << student_request.attributes.values_at(*column_names)
        end
      end
    end
end