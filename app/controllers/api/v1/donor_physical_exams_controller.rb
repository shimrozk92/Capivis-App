	# app/controllers/api/v1/donor_physical_exams_controller.rb
	module Api
		module V1
			class DonorPhysicalExamsController < ApplicationController
				before_action :set_donor
				before_action :set_donor_physical_exam, only: [:show, :update, :destroy]

				def index
					@donor_physical_exams = @donor.donor_physical_exams
					render json: @donor_physical_exams
				end

				def show
					render json: @donor_physical_exam
				end

				def create
					# if @donor_screening.status == "Accepted"
						@donor_physical_exam = @donor.donor_physical_exams.build(donor_physical_exam_params)

						if @donor_physical_exam.save
							render json: @donor_physical_exam, status: :created
						# else
						# 	render json: @donor_physical_exam.errors, status: :unprocessable_entity
						# end
					else
						render json: @donor_physical_exam.errors, status: :unprocessable_entity
					end
				end

				def update
					if @donor_physical_exam.update(donor_physical_exam_params)
						render json: @donor_physical_exam
					else
						render json: @donor_physical_exam.errors, status: :unprocessable_entity
					end
				end

				def destroy
					@donor_physical_exam.destroy
					head :no_content
				end

				private

				def set_donor
					@donor = Donor.find(params[:donor_id])
				end

				def set_donor_physical_exam
					@donor_physical_exam = @donor.donor_physical_exams.find(params[:id])
				end

				def donor_physical_exam_params
					params.require(:donor_physical_exam).permit(
						:consent_for_plasmapheresis, 
						:donor_information_flip_chart, 
						:donor_consent_3rd_party_observer, 
						:body_map_tattoos_piercings, 
						:high_risk_education_quiz, 
						:chaperone_required, 
						:health_info_disclosed, 
						:general_appearance, 
						:heent, :cardiovascular, 
						:lungs_chest, :abdomen, 
						:musculoskeletal, 
						:extremities, 
						:lymphatic, :neurological, 
						:mental_status,
						donor_consent_3rd_party_observers_attributes: [:id, :result, :comments],
						body_map_tattoo_piercings_attributes: [:id, :result, :comments],
						high_risk_education_quizzes_attributes: [:id, :result, :comments],
						chaperone_requireds_attributes: [:result, :comments],
						health_info_discloseds_attributes: [:result, :comments],
						general_appearances_attributes: [:result, :comments],
						heents_attributes: [:result, :comments],
						cardiovasculars_attributes: [:result, :comments],
						lungs_chests_attributes: [:result, :comments],
						abdomens_attributes: [:result, :comments],
						musculoskeletals_attributes: [:result, :comments],
						lymphatics_attributes: [:result, :comments],
						neurologicals_attributes: [:result, :comments],
						mental_statuses_attributes: [:result, :comments],
						donor_information_flip_chart_attributes: [:result],
						consent_for_plasmapheresis_attributes: [:result]
						)
				end
			end
		end
	end
