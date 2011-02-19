module PageHelper

  def get_nav_children(parent, navigation)
    html = ''
    if !parent.this_navigation(navigation).children.blank?
		  html << "\n\t\t\t" + '<ul>'
		  for child in parent.this_navigation(navigation).children
		    html <<  "\n\t\t\t\t" + '<li>- ' + link_to(child.page.title, (!child.page.redirect_url.blank? ? child.page.redirect_url : friendly_path(child.page)))
		    html << get_nav_children(child.page, navigation)
		    html << '</li>'
		  end
			html << "\n\t\t\t</ul>"  
		end
    html
  end  
  
  def on_this_page_or_a_child_of_this_page?(current_page, nav_page, navigation)
    is_true = false
    if current_page.id == nav_page.id 
      is_true = true
    end 
    if is_a_child?(current_page, nav_page, navigation)
      is_true = true
    end
    is_true
  end
  
  def in_this_page_tree?(current_page, nav_page, navigation)
    is_true = false
    if nav_page.id == current_page.id
      is_true = true
    end
    if is_a_parent?(current_page, nav_page, navigation)
      is_true = true
    end 
    is_true
  end
  
  def is_a_child?(current_page, nav_page, navigation)
    is_true = false
    if nav_page.this_navigation(navigation).children
      nav_page.this_navigation(navigation).children.each do |child|
        if child.id == current_page.id
          is_true = true
        end
        if is_a_child?(current_page, child.page, navigation)
          is_true = true
        end 
      end
    end
    is_true        
  end
  
  def is_a_parent?(current_page, nav_page, navigation)
    is_true = false
    if current_page.this_navigation(navigation).parent
      if nav_page.id == current_page.this_navigation(navigation).parent.id
        is_true = true
      end
      if is_a_parent?(current_page.this_navigation(navigation).parent.page, nav_page, navigation)
        is_true = true
      end 
    end
    is_true        
  end
  
end