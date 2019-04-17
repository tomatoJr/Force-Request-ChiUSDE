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
            'AALO',
            'ACCT',
            'ADDT',
            'AEGD',
            'AERO',
            'AERS',
            'AFST',
            'AGCJ',
            'AGEC',
            'AGLS',
            'AGSC',
            'AGSM',
            'ALEC',
            'ANES',
            'ALED',
            'ANSC',
            'ANTH',
            'ARAB',
            'ARCH',
            'AREN',
            'ARTS',
            'ASCC',
            'ASIA',
            'ASTR',
            'ATMO',
            'ATTR',
            'BAEN',
            'BEFB',
            'BESC',
            'BICH',
            'BIED',
            'BIMS',
            'BIOL',
            'BUAD',
            'BMEN',
            'BUSH',
            'BOTN',
            'BUSN',
            'CAEN',
            'CARC',
            'CEHD',
            'CHEM',
            'CHEN',
            'CHIN',
            'CLAS',
            'CLEN',
            'CLSL', 
            'COMM',
            'COSC',
            'CPSY',
            'CSCE', 
            'CVEN',
            'CYBR',
            'DASC',
            'DDDS',
            'DHUM',
            'DPHS',
            'DCED',
            'DDHS',
            'DIVE',
            'ECEN',
            'ECHE',
            'ECMT',
            'ECON',
            'EDAD',
            'EDCI',
            'EDHP',
            'EDTC',
            'EEBL',
            'EHRD',
            'EMED',
            'ENDO',
            'ENDG',
            'ENDS',
            'ENGL',
            'ENGR',
            'ENST',
            'ENTC',
            'ENTO',
            'EPFB',
            'EPSY',
            'ESET',
            'ESSM',
            'EURO',
            'EVEN',
            'FILM',
            'FINC',
            'FORS',
            'FIVS',
            'FREN',
            'FRSC',
            'GALV',
            'GENE',
            'GEOG',
            'GEOL',
            'GEOP',
            'GEOS',
            'GERM',
            'HCPI',
            'HBRW',
            'HEFB',
            'HHUM',
            'HISP',
            'HIST',
            'HLTH',
            'HORT',
            'HPCH',
            'HUMA',
            'IBST',
            'IBUS',
            'ICPE',
            'IDIS',
            'IMED',
            'INTA',
            'INST',
            'INTS',
            'ISEN',
            'ISTM',
            'ITAL',
            'ITDE',
            'JAPN',
            'JOUR',
            'KINE',
            'KNFB',
            'LAND',
            'LAW',
            'LBAR',
            'LDEV',
            'LING',
            'LMAS',
            'MARA',
            'MARB',
            'MARE', 
            'MARR',
            'MARS',
            'MART',
            'MASC',
            'MASE',
            'MAST',
            'MATH',
            'MCMD',
            'MEEN',
            'MEFB',
            'MEID',
            'MEMA',
            'MEPS',
            'MFCM',
            'METR',
            'MGMT',
            'MHUM',
            'MICR',
            'MKTG',
            'MLSC',
            'MMET',
            'MODL',
            'MPAT',
            'MPED',
            'MPHY',
            'MPIM',
            'MPSY',
            'MRAD',
            'MSCI',
            'MSEN',
            'NEXT',
            'MUSC',
            'MUST',
            'MXET',
            'NAUT',
            'NFSC',
            'NRSC',
            'NUEN',
            'NURS',
            'NVSC',
            'OBGY',
            'OBIO',
            'OCEN',
            'OCNG',
            'OCRE',
            'OMFP',
            'OMFR',
            'OMFS',
            'ORTH',
            'PEDD',
            'PERF',
            'PERI',
            'PETE',
            'PHAR',
            'PHEB',
            'PHEO',
            'PHIL',
            'PHPM',
            'PHLT',
            'PHYS',
            'PLAN',
            'PLPA',
            'POLS',
            'PORT',
            'POSC',
            'PROS',
            'PSAA',
            'PSYC',
            'RDNG',
            'RELS',
            'RENR',
            'RLEM',
            'RPTS',
            'RUSS',
            'SCEN',
            'SCMT',
            'SCSC',
            'SEFB',
            'SENG',
            'SOCI',
            'SOPH',
            'SOMS',
            'SPAN',
            'SPED',
            'SPMT',
            'SPSY',
            'SPSC',
            'STAT',
            'STLC',
            'TCMG',
            'SURG',
            'SYEN',
            'TAMU',
            'TCMT',
            'TEED',
            'URSC',
            'TEFB',
            'THAR',
            'UGST',
            'URPN',
            'VIBS',
            'VIZA',
            'VIST',
            'VLCS',
            'VMID',
            'VPAR',
            'VPAT',
            'VSCS',
            'VTMI',
            'VTPB',
            'VTPP',
            'WFSC',
            'WGST',
            'WMHS',
            'ZOOL',
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