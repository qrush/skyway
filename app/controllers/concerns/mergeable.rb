module Mergeable
  extend ActiveSupport::Concern

  included do
    class_attribute :mergeable_class, :permitted_params
  end

  def update
    @mergeable = mergeable_class.find(params[:id])
    @mergeable.update_attributes!(mergeable_params)

    flash[:success] = "Successfully updated #{@mergeable.name}!"
    redirect_to @mergeable
  end

  def merge
    @mergeable = mergeable_class.find(params[:id])
    @other_mergeable = mergeable_class.find(other_mergeable_params[other_mergeable_param_name])

    @mergeable.merge!(@other_mergeable)

    flash[:success] = "Successfully merged #{@mergeable.name}!"
    redirect_to @mergeable
  end

  private

    def mergeable_params
      params.require(mergeable_param_name).permit(permitted_params)
    end

    def other_mergeable_params
      params.require(mergeable_param_name).permit(other_mergeable_param_name)
    end

    def mergeable_param_name
      mergeable_class.to_s.downcase
    end

    def other_mergeable_param_name
      :"other_#{mergeable_param_name}_id"
    end

end
