class NationContacter
  @queue = :nation_contact

  def self.perform(loan_id, in_or_out)
    loan = Loan.find(loan_id)
    NbService.borrow_contact(loan, in_or_out)
  end
end
