$(document).ready(function() {
    $('#sms_body').keyup(function() {
        $('#letter_count').html(($(this).val().length) + " Zeichen");
    });

    $('.numbers-input').autocomplete({
        source: numbers
    });
});
