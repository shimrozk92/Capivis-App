module Api
	module V1
		class DonorQuestionnaireFormsController < ApplicationController
		  before_action :set_donor_questionnaire_form, only: [:show, :update, :destroy]

		  def index
		    @donor_questionnaire_forms = DonorQuestionnaireForm.all
		    render json: @donor_questionnaire_forms, include: :questionnaire_form_fields, serializer: DonorQuestionnaireFormSerializer
		  end

		  def show
		    render json: @donor_questionnaire_form, include: :questionnaire_form_fields
		  end

		  def create
		    @donor_questionnaire_form = DonorQuestionnaireForm.new(donor_questionnaire_form_params)

		    if @donor_questionnaire_form.save
		      render json: @donor_questionnaire_form, status: :created
		    else
		      render json: @donor_questionnaire_form.errors, status: :unprocessable_entity
		    end
		  end

		  def update
		    if @donor_questionnaire_form.update(donor_questionnaire_form_params)
		      render json: @donor_questionnaire_form
		    else
		      render json: @donor_questionnaire_form.errors, status: :unprocessable_entity
		    end
		  end

		  def destroy
		    @donor_questionnaire_form.destroy
		  end

		  private

		  def set_current_user
        @current_user = current_user
      end

		  def set_donor_questionnaire_form
		    @donor_questionnaire_form = DonorQuestionnaireForm.find(params[:id])
		  end

		  def donor_questionnaire_form_params
		    params.require(:donor_questionnaire_form).permit(:title, :description, :center_id)
		  end
		end
	end
end
