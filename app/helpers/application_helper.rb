#encoding: utf-8
module ApplicationHelper
  def render_class (target_path)
    if current_page?(target_path) || (target_path == root_path && current_page?(send_message_path))
      'class=active'
    else
      ''
    end
  end

  def get_status_string(status_code)
    case status_code
      when 10
        'Empfängernummer nicht korrekt'
      when 20
        'Absenderkennung nicht korrekt'
      when 30
        'Nachrichtentext nicht korrekt'
      when 31
        'Messagetyp nicht korrekt'
      when 40
        'SMS-Route nicht korrekt'
      when 50
        'Identifikation fehlgeschlagen'
      when 60
        'Nicht genügend Guthaben'
      when 70
        'Netz wird nicht abgedeckt. Andere Route wählen!'
      when 71
        'Feature nicht möglich. Andere Route wählen!'
      when 80
        'Übergabe an SMS-C fehlgeschlagen'
      when 100
        'SMS wurde angenommen und versendet'
    end
  end
end
