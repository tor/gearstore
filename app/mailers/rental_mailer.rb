class RentalMailer < ActionMailer::Base
  default from: "gear.anumc@gmail.com"
  def rental_mail(rental)
    @user = rental.user
    @rental = rental
    mail(:to => ['gear.anumc@gmail.com', @user.mail], :subject => "New Rental for #{@user.name}")
  end

end
