require 'rails/generators'

class SkinnycmsImagesGenerator < Rails::Generators::Base

  def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'images')
  end

  def copy_stylesheet_file
    copy_file "sortable_icons/minus.jpg", "public/images/skinnycms/sortable_icons/minus.jpg"

    copy_file "sortable_icons/plus.jpg", "public/images/skinnycms/sortable_icons/plus.jpg"

    copy_file "sortable_icons/skrepka.jpg", "public/images/skinnycms/sortable_icons/skrepka.jpg"

    copy_file "admin/arrow.gif", "public/images/skinnycms/admin/arrow.gif"

    copy_file "admin/arrow1.gif", "public/images/skinnycms/admin/arrow1.gif"

    copy_file "admin/arrow2.gif", "public/images/skinnycms/admin/arrow2.gif"

    copy_file "admin/bg-actions.gif", "public/images/skinnycms/admin/bg-actions.gif"

    copy_file "admin/bg-add-nav-active.gif", "public/images/skinnycms/admin/bg-add-nav-active.gif"

    copy_file "admin/bg-add-nav-li.gif", "public/images/skinnycms/admin/bg-add-nav-li.gif"

    copy_file "admin/bg-add.gif", "public/images/skinnycms/admin/bg-add.gif"

    copy_file "admin/bg-area.gif", "public/images/skinnycms/admin/bg-area.gif"

    copy_file "admin/bg-bar-l.gif", "public/images/skinnycms/admin/bg-bar-l.gif"

    copy_file "admin/bg-bar-r.gif", "public/images/skinnycms/admin/bg-bar-r.gif"

    copy_file "admin/bg-blue-l.gif", "public/images/skinnycms/admin/bg-blue-l.gif"

    copy_file "admin/bg-blue-r.gif", "public/images/skinnycms/admin/bg-blue-r.gif"

    copy_file "admin/bg-body.gif", "public/images/skinnycms/admin/bg-body.gif"

    copy_file "admin/bg-button-l.gif", "public/images/skinnycms/admin/bg-button-l.gif"

    copy_file "admin/bg-button-r.gif", "public/images/skinnycms/admin/bg-button-r.gif"

    copy_file "admin/bg-dark-gray-l.gif", "public/images/skinnycms/admin/bg-dark-gray-l.gif"

    copy_file "admin/bg-dark-gray-r.gif", "public/images/skinnycms/admin/bg-dark-gray-r.gif"

    copy_file "admin/bg-edit-box.gif", "public/images/skinnycms/admin/bg-edit-box.gif"

    copy_file "admin/bg-emai-text.gif", "public/images/skinnycms/admin/bg-emai-text.gif"

    copy_file "admin/bg-gray-area.gif", "public/images/skinnycms/admin/bg-gray-area.gif"

    copy_file "admin/bg-gray-area1.gif", "public/images/skinnycms/admin/bg-gray-area1.gif"

    copy_file "admin/bg-gray-l.gif", "public/images/skinnycms/admin/bg-gray-l.gif"

    copy_file "admin/bg-gray-r.gif", "public/images/skinnycms/admin/bg-gray-r.gif"

    copy_file "admin/bg-header.gif", "public/images/skinnycms/admin/bg-header.gif"

    copy_file "admin/bg-inner.gif", "public/images/skinnycms/admin/bg-inner.gif"

    copy_file "admin/bg-long-text.gif", "public/images/skinnycms/admin/bg-long-text.gif"

    copy_file "admin/bg-main.gif", "public/images/skinnycms/admin/bg-main.gif"

    copy_file "admin/bg-search-txt.gif", "public/images/skinnycms/admin/bg-search-txt.gif"

    copy_file "admin/bg-seo-fields.gif", "public/images/skinnycms/admin/bg-seo-fields.gif"

    copy_file "admin/bg-submit.gif", "public/images/skinnycms/admin/bg-submit.gif"

    copy_file "admin/bg-tabset-active.gif", "public/images/skinnycms/admin/bg-tabset-active.gif"

    copy_file "admin/bg-tabset.gif", "public/images/skinnycms/admin/bg-tabset.gif"

    copy_file "admin/bg-tbody-l.gif", "public/images/skinnycms/admin/bg-tbody-l.gif"

    copy_file "admin/bg-tbody-r.gif", "public/images/skinnycms/admin/bg-tbody-r.gif"

    copy_file "admin/bg-text-area.gif", "public/images/skinnycms/admin/bg-text-area.gif"

    copy_file "admin/bg-text-big.gif", "public/images/skinnycms/admin/bg-text-big.gif"

    copy_file "admin/bg-text-small.gif", "public/images/skinnycms/admin/bg-text-small.gif"

    copy_file "admin/bg-textarea.gif", "public/images/skinnycms/admin/bg-textarea.gif"

    copy_file "admin/bg-thead-l.gif", "public/images/skinnycms/admin/bg-thead-l.gif"

    copy_file "admin/bg-thead-r.gif", "public/images/skinnycms/admin/bg-thead-r.gif"

    copy_file "admin/bg-title.gif", "public/images/skinnycms/admin/bg-title.gif"

    copy_file "admin/btn-draft-l.gif", "public/images/skinnycms/admin/btn-draft-l.gif"

    copy_file "admin/btn-draft-r.gif", "public/images/skinnycms/admin/btn-draft-r.gif"

    copy_file "admin/btn-gray-l.gif", "public/images/skinnycms/admin/btn-gray-l.gif"

    copy_file "admin/btn-gray-r.gif", "public/images/skinnycms/admin/btn-gray-r.gif"

    copy_file "admin/divider.gif", "public/images/skinnycms/admin/divider.gif"

    copy_file "admin/ico-l.gif", "public/images/skinnycms/admin/ico-l.gif"

    copy_file "admin/ico-line.gif", "public/images/skinnycms/admin/ico-line.gif"

    copy_file "admin/ico-r.gif", "public/images/skinnycms/admin/ico-r.gif"

    copy_file "admin/ico1.gif", "public/images/skinnycms/admin/ico1.gif"

    copy_file "admin/ico2.gif", "public/images/skinnycms/admin/ico2.gif"

    copy_file "admin/ico3.gif", "public/images/skinnycms/admin/ico3.gif"

    copy_file "admin/ico4.gif", "public/images/skinnycms/admin/ico4.gif"

    copy_file "admin/ico5.gif", "public/images/skinnycms/admin/ico5.gif"

    copy_file "admin/ico6.gif", "public/images/skinnycms/admin/ico6.gif"

    copy_file "admin/logo-flickr.gif", "public/images/skinnycms/admin/logo-flickr.gif"

    copy_file "admin/logo-tumblr.gif", "public/images/skinnycms/admin/logo-tumblr.gif"

    copy_file "admin/logo-vimeo.gif", "public/images/skinnycms/admin/logo-vimeo.gif"

    copy_file "admin/logo.gif", "public/images/skinnycms/admin/logo.gif"

    copy_file "admin/separator.gif", "public/images/skinnycms/admin/separator.gif"

    copy_file "admin/separator1.gif", "public/images/skinnycms/admin/separator1.gif"

    copy_file "admin/separator2.gif", "public/images/skinnycms/admin/separator2.gif"

    copy_file "admin/tbody-divider.gif", "public/images/skinnycms/admin/tbody-divider.gif"

    copy_file "admin/text-icons.gif", "public/images/skinnycms/admin/text-icons.gif"

    copy_file "admin/thead-divider.gif", "public/images/skinnycms/admin/thead-divider.gif"
  end
end
