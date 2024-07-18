module Api
	module V1
		class DonorQuestionnairesController < ApplicationController
			before_action :set_donor_questionnaire, only: [:show, :update, :destroy]

			 def index
		    @donor_questionnaires = DonorQuestionnaire.where(donor_id: current_user.id)
		    render json: @donor_questionnaires.map { |dq| donor_questionnaire_json(dq) }
		  end

		  def show
		    render json: donor_questionnaire_json(@donor_questionnaire)
		  end

		  def create
        @donor_questionnaire = DonorQuestionnaire.new(donor_questionnaire_params)
        @donor_questionnaire.donor_id = current_user.id

        if @donor_questionnaire.save
          render json: donor_questionnaire_json(@donor_questionnaire), status: :created
        else
          render json: @donor_questionnaire.errors, status: :unprocessable_entity
        end
      end

		  def update
        if @donor_questionnaire.update(donor_questionnaire_params)
          render json: donor_questionnaire_json(@donor_questionnaire)
        else
          render json: @donor_questionnaire.errors, status: :unprocessable_entity
        end
      end

		  def destroy
		    @donor_questionnaire.destroy
		  end

		  private

		  def set_donor_questionnaire
		    @donor_questionnaire = DonorQuestionnaire.find(params[:id])
		  end

		  def donor_questionnaire_params
		    params.require(:donor_questionnaire).permit(:donor_questionnaire_form_id,:donor_id, responses: {})
		  end

		  def donor_questionnaire_json(donor_questionnaire)
		    {
		      id: donor_questionnaire.id,
          donor_id: donor_questionnaire.donor_id,
          donor_questionnaire_form_id: donor_questionnaire.donor_questionnaire_form_id,
          question_answers: donor_questionnaire.question_answers
        }
		  end
		end
	end
end
