=begin
DonorPhysicalExam 
donor    :references 
consent_for_plasmapheresis       :string 
donor_information_flip_chart     :string 
donor_consent_3rd_party_observer :string 
body_map_tattoos_piercings       :string 
high_risk_education_quiz         :string 
chaperone_required               :boolean 
health_info_disclosed            :boolean 
general_appearance               :string 
heent              :string 
cardiovascular     :string 
lungs_chest        :string 
abdomen            :string 
musculoskeletal    :string 
extremities        :string 
lymphatic          :string 
neurological       :string 
mental_status      :string

=end

class DonorPhysicalExam < ApplicationRecord
  belongs_to :donor
  
  has_many :donor_consent_3rd_party_observers
  has_many :body_map_tattoo_piercings
  has_many :high_risk_education_quizzes
  has_many :chaperone_requireds
  has_many :health_info_discloseds
  has_many :general_appearances
  has_many :heents
  has_many :cardiovasculars
  has_many :lungs_chests
  has_many :musculoskeletals
  has_many :extremities
  has_many :lymphatics
  has_many :neurologicals
  has_many :mental_statuses
  # has_many :abdomens
  # validates :consent_for_plasmapheresis, :donor_information_flip_chart, :donor_consent_3rd_party_observer, :body_map_tattoos_piercings, :high_risk_education_quiz, :general_appearance, :heent, :cardiovascular, :lungs_chest, :abdomen, :musculoskeletal, :extremities, :lymphatic, :neurological, :mental_status, presence: true
  # validates :chaperone_required, :health_info_disclosed, inclusion: { in: [true, false] }

  accepts_nested_attributes_for :donor_consent_3rd_party_observers
  accepts_nested_attributes_for :body_map_tattoo_piercings
  accepts_nested_attributes_for :high_risk_education_quizzes
  accepts_nested_attributes_for :chaperone_requireds
  accepts_nested_attributes_for :health_info_discloseds
  accepts_nested_attributes_for :general_appearances
  accepts_nested_attributes_for :heents
  accepts_nested_attributes_for :cardiovasculars
  accepts_nested_attributes_for :lungs_chests
  accepts_nested_attributes_for :musculoskeletals
  accepts_nested_attributes_for :extremities
  accepts_nested_attributes_for :lymphatics
  accepts_nested_attributes_for :neurologicals
  accepts_nested_attributes_for :mental_statuses
  # accepts_nested_attributes_for :abdomens
end
