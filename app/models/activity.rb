class Activity < ActiveRecord::Base

def self.log_activity(model, user_id, user_name, belongsTo, action, params)
 log = Activity.new
 log.model = model
 log.user_id = user_id
 log.user_name = user_name
 log.belongsTo = belongsTo
 log.action_performed = action
 log.data = params
 log.save
end 

  ## Auto generated code using java @ Ravi
  ## Begin

  def self.admin_grid(params = {}, active_state = nil)
    grid = model_filter(params[:model]).
          user_id_filter(params[:user_id]).
          user_name_filter(params[:user_name]).
          belongsTo_filter(params[:belongsTo]).
          action_performed_filter(params[:action_performed]).
          data_filter(params[:data])
  end


  private


    def self.model_filter(model)
      if model.present?
        where("activities.model LIKE ?","%#{model}%")
      else
        all
      end
    end

    def self.user_id_filter(user_id)
      if user_id.present?
        where("activities.user_id = ?", user_id)
      else
        all
      end
    end

    def self.user_name_filter(user_name)
      if user_name.present?
        where("activities.user_name LIKE ?","%#{user_name}%")
      else
        all
      end
    end

    def self.belongsTo_filter(belongsTo)
      if belongsTo.present?
        where("activities.belongsTo = ?", belongsTo)
      else
        all
      end
    end

    def self.action_performed_filter(action_performed)
      if action_performed.present?
        where("activities.action_performed LIKE ?","%#{action_performed}%")
      else
        all
      end
    end

    def self.data_filter(data)
      if data.present?
        where("activities.data LIKE ?","%#{data}%")
      else
        all
      end
    end

  ## Auto generated code using java @ Ravi
  ## end

end
