ActiveAdmin.register Link do

	permit_params :approved_status, :title, :url, :description, :points, :hot_score	
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

	form do |f| 
		f.inputs 'Link Details' do 
			f.input :title
			f.input :url
			f.input :description
			f.input :approved_status
			f.input :points
			f.input :hot_score	
		end
		f.actions
	end

end
