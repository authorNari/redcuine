# -*- coding: utf-8 -*-
class Redticket::MailSender
  def self.send
    mail = Redticket::Mail.new
    return puts mail.to_s if Redticket::CONFIG.dry_run
    if Redticket::CONFIG.smtp_enable_tls
      send_tls_mail(mail)
    else
      send_mail(mail)
    end
  end

  private
  def self.send_tls_mail(mail)
    if /1.9/ === RUBY_VERSION
      smtp = Net::SMTP.new(Redticket::CONFIG.smtp_hostname,
                           Redticket::CONFIG.smtp_port)
      smtp.enable_starttls
      smtp.start(Redticket::CONFIG.smtp_domain,
                 Redticket::CONFIG.smtp_account,
                 Redticket::CONFIG.smtp_password,
                 Redticket::CONFIG.smtp_format) do |s|
        s.send_mail mail.to_s, Redticket::CONFIG.from_address, Redticket::CONFIG.to_address
      end
    else
      require "tlsmail"
      Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
      Net::SMTP.start(Redticket::CONFIG.smtp_hostname,
                      Redticket::CONFIG.smtp_port,
                      Redticket::CONFIG.smtp_domain,
                      Redticket::CONFIG.smtp_account,
                      Redticket::CONFIG.smtp_password,
                      Redticket::CONFIG.smtp_format) do |s|
        s.send_mail mail.to_s, Redticket::CONFIG.from_address, Redticket::CONFIG.to_address
      end
    end
  end

  def self.send_mail(mail)
    Net::SMTP.start(Redticket::CONFIG.smtp_hostname, Redticket::CONFIG.port) do |smtp|
      smtp.send_mail mail.to_s, Redticket::CONFIG.from_address, Redticket::CONFIG.to_address
    end
  end
end
