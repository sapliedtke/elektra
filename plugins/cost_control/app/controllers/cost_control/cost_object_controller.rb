module CostControl
  class CostObjectController < CostControl::ApplicationController
    authorization_required

    before_filter :load_masterdata

    def show
      if @scoped_project_id
        render action: 'project_show'
      else
        render action: 'domain_show'
      end
    end

    def edit
      if @scoped_project_id
        render action: 'project_edit'
      else
        render action: 'domain_edit'
      end
    end

    def update
      if @scoped_project_id
        attrs = params.require(:project_masterdata).permit(:cost_object_type, :cost_object_id, :cost_object_inherited)
      else
        attrs = params.require(:domain_masterdata).permit(:cost_object_type, :cost_object_id, :cost_object_responsibleController)
      end

      # normalize "cost_object_inherited" to Boolean
      attrs[:cost_object_inherited] = attrs[:cost_object_inherited] == '1'

      if @masterdata.update_attributes(attrs)
        redirect_to plugin('cost_control').cost_object_path
        return
      else
        if @scoped_project_id
          render action: 'project_edit'
        else
          render action: 'domain_edit'
        end
      end
    end

    private

    def load_masterdata
      if @scoped_project_id
        @masterdata = services.cost_control.find_project_masterdata(@scoped_project_id)
      else
        @masterdata = services.cost_control.find_domain_masterdata(@scoped_domain_id)
      end
    end

  end
end
