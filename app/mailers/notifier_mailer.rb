class NotifierMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier_mailer.invite.subject
  #
  def invite(player, invite)
    @token = invite
    @player = player

    mail from: 'plates@arpcentral',  to: @player.email, subject: "You've been invited to play the best license plate game ever"
  end
end
