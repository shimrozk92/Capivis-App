module Api
  module V1
    class DonorQuestionnairesController < ApplicationController
      before_action :set_donor_questionnaire, only: [:show, :update, :destroy]

      def index
        @donor_questionnaires = DonorQuestionnaire.all
        render json: @donor_questionnaires.map { |dq| donor_questionnaire_json(dq) }
      end

      def show
        render json: donor_questionnaire_json(@donor_questionnaire)
      end

      def create
        @donor_questionnaire = DonorQuestionnaire.new(donor_questionnaire_params)
        @donor_questionnaire.donor_id = current_user.profileable_id

        if @donor_questionnaire.save
          create_donation
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
        params.require(:donor_questionnaire).permit(:donor_questionnaire_form_id, responses: {})
      end

      def donor_questionnaire_json(donor_questionnaire)
        {
          id: donor_questionnaire.id,
          donor_id: donor_questionnaire.donor_id,
          donor_questionnaire_form_id: donor_questionnaire.donor_questionnaire_form_id,
          question_answers: donor_questionnaire.question_answers
        }
      end

      def create_donation
        donor = Donor.find(current_user.profileable_id)
        last_donation = donor.donations.order(created_at: :desc).first

        if last_donation.nil? || (Time.zone.now.to_date - last_donation.created_at.to_date).to_i > 1
          Donation.create(donor: donor, status: 'pending')
          next_donation_date = Time.zone.now.to_date + 2.days

          if last_donation.nil? || (next_donation_date - last_donation.created_at.to_date).to_i > 1
            Donation.create(donor: donor, status: 'pending', scheduled_at: next_donation_date)
            render json: donor_questionnaire_json(@donor_questionnaire), status: :created and return
          else
            render json: { error: 'Cannot create donations on consecutive days' }, status: :unprocessable_entity and return
          end
        else
          render json: { error: 'Cannot create donations on consecutive days' }, status: :unprocessable_entity and return
        end
      end
    end
  end
end
