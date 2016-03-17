module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == params[:sort] && params[:direction] == 'asc' ? 'desc' : 'asc'
    if params[:query].present?
      title
    else
      link_to title, sort: column, direction: direction
    end
  end

  def human_boolean(boolean)
    boolean ? 'Yes' : 'No'
  end

  def loan(user, book)
    Loan.where(user: user, book: book).last
  end
end
