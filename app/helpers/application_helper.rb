module ApplicationHelper
	def date_format(t)
		t.strftime('%Y %b %e')
	end

	def problem_tag(s)
		content_tag :span, :class => 'overdue' do
			s
		end
	end
	
	def overdue_tag(rental)
		if rental.active?
			if rental.overdue?
				content_tag :span, :class => 'overdue' do
					'overdue'
				end
			else 
				content_tag :span, :class => 'not_overdue' do
					'not overdue'
				end
			end
		else
			content_tag :span, :class => 'not_overdue' do
				'returned'
			end
		end
	end

	def return_on_tag(rental)
		if rental.overdue?
			content_tag :span, :class => 'overdue' do
				rental.return_on_pretty
			end
		else
			rental.return_on_pretty
		end
	end
  
  def admins
    [User.find(session[:user_id])] + User.admins
  end
end
