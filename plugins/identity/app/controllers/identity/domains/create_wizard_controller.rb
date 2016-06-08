module Identity
  module Domains
    # This controller implemnts the workflow to create a project
    class CreateWizardController < DashboardController
      before_filter :load_and_authorize_inquiry

      def new
        @project = Identity::Project.new(nil,{})
        @project.attributes = @inquiry.payload if @inquiry
      end

      def create
        # user is not allowed to create a project (maybe)
        # so use admin identity for that!
        @project = services.identity.new_project
        @project.attributes = params.fetch(:project, {}).merge(domain_id: @scoped_domain_id)
        @project.enabled = @project.enabled == 'true'

        if @project.save
          services.identity.grant_project_user_role_by_role_name(@project.id, current_user.id, 'admin')
          services.identity.clear_auth_projects_tree_cache
          
          flash[:notice] = "Project #{@project.name} successfully created."
          if @inquiry
            inquiry = services.inquiry.set_inquiry_state(@inquiry.id, :approved, "Project #{@project.name} approved and created by #{current_user.full_name}")
            services.identity.grant_project_user_role_by_role_name(@project.id, inquiry.requester.uid, 'admin')
            render 'identity/domains/create_wizard/create.js'
          else
            redirect_to :domain
          end
        else
          flash.now[:error] = @project.errors.full_messages.to_sentence
          render action: :new
        end
      end

      def load_and_authorize_inquiry
        return if params[:inquiry_id].blank?
        @inquiry = services.inquiry.get_inquiry(params[:inquiry_id])

        if @inquiry 
          unless current_user.is_allowed?("identity:project_create", {project: {domain_id: @scoped_domain_id} })
            render template: '/dashboard/not_authorized'
          end
        else
          render template: '/identity/domains/create_wizard/not_found'
        end
      end
    end
  end
end
