// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function display_education_form(student_id, education_type){
    //var forms = ["in_school_form", "college_form", "pg_form", "phd_form", "professional_form", "others_form"]
    //for(i=0; i<forms.length; i++){

    //document.getElementById(forms[i]).style.display = "none";
    //}
    //document.getElementById(form_id).style.display = "block";
    new Ajax.Updater('education_form', "/students/"+student_id+"/get_education_form?education_type="+education_type,
    {
        evalScripts: true,
        asynchronous: true,
        method: 'get'
    });
}

function display_tab(tab_id){
    var tabs = ["personal","education","others"]
    for(i=0; i<tabs.length; i++){

        document.getElementById(tabs[i]).style.display = "none";
    }
    document.getElementById(tab_id).style.display = "block";
}

function display_education_from(mentor_id, education_type){
    //var forms = ["professor_form", "school_form", "corporate_form", "research_form", "professional_form", "good_form"]
    //for(i=0; i<forms.length; i++){

    // document.getElementById(forms[i]).style.display = "none";
    //}
    //document.getElementById(form_id).style.display = "block";
    new Ajax.Updater('education_form', '/mentors/'+mentor_id+"/get_education_form?education_type="+education_type,
    {
        evalScripts: true,
        asynchronus: true,
        method: 'get'
    });

}
//  $.ajax({
//    url: '/mentors/'+mentor_id+"/get_education_form?education_type="+education_type

//})
//}

function display_education_profile_form(student_id, education_type){
    new Ajax.Updater('education_profile_form', "/students/"+student_id+"/get_education_profile_form?education_type="+education_type,
    {
        evalScripts: true,
        asynchronous: true,
        method: 'get'
    });
}

function display_education_mentor_profile_form(mentor_id, education_type){
    new Ajax.Updater('education_profile_form', "/mentors/"+mentor_id+"/get_education_profile_form?education_type="+education_type,
    {
        evalScripts: true,
        asynchronous: true,
        method: 'get'
    });
}

function show_login_form(){
    new Ajax.Request("/login",
    {
        evalScripts: true,
        asynchronous: true,
        method: 'get',
        onSuccess: function(transport) {
            $('popup_body').innerHTML = transport.responseText;
            $('overlay').style.display = "block"
            $('popup_box').style.display = "block"
            $('forgot_form').style.display = "none"
        }
    })

}

function signup(){
    new Ajax.Request("/users/new/",
    {
        evalScripts: true,
        asynchronous: true,
        method: 'get',
        onSuccess: function(transport) {
            $('popup_body').innerHTML = transport.responseText;
            $('overlay').style.display = "block"
            $('popup_box').style.display = "block"
        }
    })
}

function faq(){
    new Ajax.Request("/users/faq/",
    {
        evalScripts: true,
        asynchronous: true,
        method: 'get',
        onSuccess: function(transport) {
            $('popup_body').innerHTML = transport.responseText;
            $('overlay').style.display = "block"
            $('popup_box').style.display = "block"
        }
    })
}

function show_forgot_password(){
    //jQuery('forgot_password_flash').html("");
    //jQuery('#email').val("");
    $('forgot_form').style.display = "block"
    $('user_login_form').style.display = "none"
//jQuery('#forgot_password_form').show();
}

//javascript for student and mentor help messages.
function student_school_help(){
    $('overlay').style.display = "block"
    $('popup_body3').innerHTML = "<strong>Help:</strong>&nbsp;&nbsp;&nbsp;&nbsp;Primary,secondary and High school students falls under this category"
    $('popup_box3').style.display  = "block"
}
function student_college_help(){
    $('overlay').style.display = "block"
    $('popup_body3').innerHTML = "<p><strong>Help:</strong>&nbsp;&nbsp;&nbsp;&nbsp;Under-graduate students who are pursuing their bachelor degree course falls under this category.</p>"
    $('popup_box3').style.display  = "block"
}
function student_phd_help(){
    $('overlay').style.display = "block"
    $('popup_body3').innerHTML = "<p><strong>Help:</strong>&nbsp;&nbsp;&nbsp;&nbsp;Ph.D students doing doctorate in any stream/field, falls under this category.</p>"
    $('popup_box3').style.display  = "block"
}
function student_pg_help(){
    $('overlay').style.display = "block"
    $('popup_body3').innerHTML = "<p><strong>Help:</strong>&nbsp;&nbsp;&nbsp;&nbsp;Post-Graduate students doing master's in any stream/fields, falls under this category.</p>"
    $('popup_box3').style.display  = "block"
}
function student_professional_help(){
    $('overlay').style.display = "block"
    $('popup_body3').innerHTML = "<p><strong>Help:</strong>&nbsp;&nbsp;&nbsp;&nbsp;This category is for professionals who are working in any stream/field, and would like to learn something new develop or en chance their skills. </p>"
    $('popup_box3').style.display  = "block"
}
function student_others_help(){
    $('overlay').style.display = "block"
    $('popup_body3').innerHTML = "<p><strong>Help:</strong>&nbsp;&nbsp;&nbsp;&nbsp;Those people who belongs in none of above category will register under OTHERS category, regardless of their education and professional scope.</p>"
    $('popup_box3').style.display  = "block"
}
function mentor_professor_help(){
    $('overlay').style.display = "block"
    $('popup_body3').innerHTML = "<p><strong>Help:</strong>&nbsp;&nbsp;&nbsp;&nbsp;Professors/lectorers who are would to share theire knowledge with others falls under this category</p>"
    $('popup_box3').style.display  = "block"
}
function mentor_school_help(){
    $('overlay').style.display = "block"
    $('popup_body3').innerHTML = "<p><strong>Help:</strong>&nbsp;&nbsp;&nbsp;&nbsp;School Teacher who are would like to share their knowledge students, falls under this</p>"
    $('popup_box3').style.display  = "block"
}
function mentor_corporate_help(){
    $('overlay').style.display = "block"
    $('popup_body3').innerHTML = "<p><strong>Help:</strong>&nbsp;&nbsp;&nbsp;&nbsp;The trainers who trains people in corporate world, falls under this category.</p>"
    $('popup_box3').style.display  = "block"
}
function mentor_research_help(){
    $('overlay').style.display = "block"
    $('popup_body3').innerHTML = "<p><strong>Help:</strong>&nbsp;&nbsp;&nbsp;&nbsp;Those people who are doing some kind of research in any field and would like to share knowledge with others, falls under this category</p>"
    $('popup_box3').style.display  = "block"
}
function mentor_professional_help(){
    $('overlay').style.display = "block"
    $('popup_body3').innerHTML = "<p><strong>Help:</strong>&nbsp;&nbsp;&nbsp;&nbsp;Any kind of professional in any field and would like to share knowledge with others, fall under this category</p>"
    $('popup_box3').style.display  = "block"
}
function mentor_others_help(){
    $('overlay').style.display = "block"
    $('popup_body3').innerHTML = "<p><strong>Help:</strong>&nbsp;&nbsp;&nbsp;&nbsp;This category is interesting.if you feel you are good in anything(doesn't matter it's cooking, music, art, language, calligraphy, etc), regardless of educational background and would like to share knowledge and experience with others, falls under this category </p>"
    $('popup_box3').style.display  = "block"
}
function accept_course_message(courses_student_id){
    new Ajax.Request("/courses/"+courses_student_id+"/accept/",
    {
        evalScripts: true,
        asynchronous: true,
        method: 'get',
        onSuccess: function(transport) {
            $('popup_body4').innerHTML = transport.responseText;
            $('overlay').style.display = "block"
            $('popup_box4').style.display = "block"
        }
    })
}

function reject_course_message(courses_student_id){
    new Ajax.Request("/courses/"+courses_student_id+"/reject/",
    {
        evalScripts: true,
        asynchronous: true,
        method: 'get',
        onSuccess: function(transport) {
            $('popup_body4').innerHTML = transport.responseText;
            $('overlay').style.display = "block"
            $('popup_box4').style.display = "block"
        }
    })
}
function current_course(){
    new Ajax.Request("/courses/current",
    {
        evalScripts: true,
        asynchronous: true,
        method: 'get',
        onSuccess: function(transport) {
            $('popup_body5').innerHTML = transport.responseText;
            $('overlay1').style.display = "block"
            $('popup_box5').style.display = "block"
        }
    })
}

function student_current_course(){
    new Ajax.Request("/courses/student_current_course",
    {
        evalScripts: true,
        asynchronous: true,
        method: 'get',
        onSuccess: function(transport) {
            $('popup_body5').innerHTML = transport.responseText;
            $('overlay1').style.display = "block"
            $('popup_box5').style.display = "block"
        }
    })
}
function mentor_current_course(mentor_id){
    new Ajax.Request("/mentors/"+mentor_id+"/mentor_current_course",
    {
        evalScripts: true,
        asynchronous: true,
        method: 'get',
        onSuccess: function(transport) {
            $('popup_body5').innerHTML = transport.responseText;
            $('overlay1').style.display = "block"
            $('popup_box5').style.display = "block"
        }
    })
}
function mentor_other_message(mentor_id){
    new Ajax.Request("/mentors/"+mentor_id+"/other_message",
    {
        evalScripts: true,
        asynchronous: true,
        method: 'get',
        onSuccess: function(transport) {
            $('popup_body2').innerHTML = transport.responseText;
            $('overlay').style.display = "block"
            $('popup_box2').style.display = "block"
        }
    })
}

function student_other_message(student_id){
    new Ajax.Request("/students/"+student_id+"/other_message",
    {
        evalScripts: true,
        asynchronous: true,
        method: 'get',
        onSuccess: function(transport) {
            $('popup_body2').innerHTML = transport.responseText;
            $('overlay').style.display = "block"
            $('popup_box2').style.display = "block"
        }
    })
}

function hide_popup(){

    if($('popup_box')){
        $('popup_body').innerHTML = "";
        $('popup_box').style.display = "none"
    }
    if($('popup_box2')){
        $('popup_body2').innerHTML = "";
        $('popup_box2').style.display = "none"
    }
    if($('popup_box3')){
        $('popup_body3').innerHTML = "";
        $('popup_box3').style.display = "none"
    }
    if($('popup_box4')){
        $('popup_body4').innerHTML = "";
        $('popup_box4').style.display = "none"
    }
    if($('popup_box5')){
        $('popup_body5').innerHTML = "";
        $('popup_box5').style.display = "none"
    }
    if($('overlay1')){
        $('overlay1').style.display = "none"
    }
    if($('overlay')){
        $('overlay').style.display = "none"
    }
}
    
function select_file_type(val){
    if(val == 'doc'){
        document.getElementById('document_form').style.display = "block";
        document.getElementById('video_form').style.display = "none";
    }else{
        document.getElementById('document_form').style.display = "none";
        document.getElementById('video_form').style.display = "block";
    }
}
function display_categories(val){
    if(val == 'yes'){
        document.getElementById('categories').style.display = "block";
    }else{
        document.getElementById('categories').style.display = "none";
    }
}

// this is for advance search
function changeOption(val){
    if(val == 'Mentor'){
        document.getElementById('student_education').style.display = "none";
        document.getElementById('mentor_fields').style.display = "block";
        document.getElementById('course').style.display = "block";
    }else{
        document.getElementById('mentor_fields').style.display = "none";
        document.getElementById('course').style.display = "none";
        document.getElementById('student_education').style.display = "block";
    }
}
function remove_fields(link) {
    $(link).previous("input[type=hidden]").value = "1";
    $(link).up(".fields").hide();
}

function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g")
    $(link).up().insert({
        before: content.replace(regexp, new_id)
    });
}


//functions for password fields
function current_setPass() {
    document.getElementById('current_password_text').style.display = 'none';
    document.getElementById('current_password').style.display = 'inline';
    document.getElementById('user_password').focus();
}
function current_checkPass() {
    if (document.getElementById('user_password').value.length == 0) {
        document.getElementById('current_password_text').style.display = 'inline';
        document.getElementById('current_password').style.display = 'none';
    }
}

function new_setPass() {
    document.getElementById('new_password_text').style.display = 'none';
    document.getElementById('new_password').style.display = 'inline';
    document.getElementById('user_password').focus();
}
function new_checkPass() {
    if (document.getElementById('user_password').value.length == 0) {
        document.getElementById('new_password_text').style.display = 'inline';
        document.getElementById('new_password').style.display = 'none';
    }
}

function confirm_setPass() {
    document.getElementById('confirm_password_text').style.display = 'none';
    document.getElementById('confirm_password').style.display = 'inline';
    document.getElementById('user_password_confirmation').focus();
}
function conform_checkPass() {
    if (document.getElementById('user_password_confirmation').value.length == 0) {
        document.getElementById('confirm_password_text').style.display = 'inline';
        document.getElementById('confirm_password').style.display = 'none';
    }
}


function login_setPass() {
    document.getElementById('login_password_text').style.display = 'none';
    document.getElementById('login_password').style.display = 'inline';
    document.getElementById('password').focus();
}
function login_checkPass() {
    if (document.getElementById('password').value.length == 0) {
        document.getElementById('login_password_text').style.display = 'inline';
        document.getElementById('login_password').style.display = 'none';
    }
}
function status_type(val){
    if(val == 'mentor'){
      document.getElementById('mentor_status_fields').style.display = "block";
      document.getElementById('student_status_fields').style.display = "none";
    }else{
      document.getElementById('mentor_status_fields').style.display = "none";
      document.getElementById('student_status_fields').style.display = "block";
    }
  }
