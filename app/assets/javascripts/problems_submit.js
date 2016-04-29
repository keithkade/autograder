/* jshint browser:true, devel:true */
/* global $, ace */

/**
 * Created by kade on 4/10/16.
 * This is being included on all pages, even though it's only needed on one
 * this is harder to fix in rails than it should be
*/

var LOADER_ID = 'loader-area';
var SUBMIT_BUTTON_ID = 'submit-btn';
var MODAL_ID = 'submission-results-modal';

var pageLoadTime = new Date();
var editor;

function Setup() {
    console.log("setting up");
    
    //this is a naive way to make sure this script doesn't run on all pages
    if (!document.getElementById('editor')){
        return;
    }
    
    //set up ace
    editor = ace.edit("editor");
    editor.setTheme("ace/theme/twilight");
    editor.session.setMode("ace/mode/" + document.getElementById('editor').getAttribute('data-lang'));
    editor.setOptions({
        enableBasicAutocompletion: true,
        enableSnippets: true,
        highlightSelectedWord: true,
        highlightActiveLine: true,
    });
    
    //Show ace shortcuts on 
    ace.config.loadModule("ace/ext/keybinding_menu", function(module) {
        module.init(editor);
    });
    
    //popup on succesful submit
    $('#submission-results-modal').on('hide.bs.modal', function(e) { CopyModalContentsToPage(); });
}

function CopyModalContentsToPage() {
  $('#submission-results-after').html($('#submission-results').html());
}

function ShowSubmissionModal(id) {
    $('#' + id).modal('show');
}

function ShowLoader(id) {
    $('#' + id).append('<div class="loader">Loading...</div>');
}

function HideLoader(id) {
    $('#' + id).empty();
}

function ShowSubmitButton(id) {
    $('#' + id).removeClass('hide');
}

function HideSubmitButton(id) {
    $('#' + id).addClass('hide');
}

function CreateElement(tagname, content, className){
    var elem = document.createElement(tagname);
    if (content) elem.innerHTML = content;
    if (className) elem.className = className;
    return elem;
}

/** give a list of html elements, delete all their children */ 
function DeleteChildren() {
    for (var i = 0; i < arguments.length; i++) {
        var element = arguments[i];
        while (element.firstChild){
            element.removeChild(element.firstChild);
        }
    }
}

function SubmitCode(code, containerId){
    var responseContainer = document.getElementById(containerId); 
    DeleteChildren(responseContainer);
    DeleteChildren(document.getElementById('submission-results-after'));

    HideSubmitButton(SUBMIT_BUTTON_ID);
    ShowLoader(LOADER_ID);

    $.get(document.URL + '/evaluate', { code: code, 
                                        time_submitted: Math.trunc(new Date().getTime()/1000),
                                        page_loaded_at: Math.trunc(pageLoadTime.getTime()/1000)
                                      }, 
    function(response) {
        
        var problemPassed = false;

        HideLoader(LOADER_ID);
        ShowSubmitButton(SUBMIT_BUTTON_ID);
        DeleteChildren(responseContainer);

        var status = CreateElement('div', '', 'submission-status');
        var result = CreateElement('div');
        var tbl = CreateElement('table', '', 'table');
        var tblHeader = tbl.createTHead();
        var headerRow = tblHeader.insertRow(0);
        var appendTH = function(header, txt) {
            var th = document.createElement('th');
            th.innerHTML = txt;
            header.appendChild(th);
        };
        
        var tblBody = document.createElement('tbody');
        tbl.appendChild(tblBody);
        
        if (response.status == "success") {
            status.innerHTML = "Code Succesfully Evaluated";
            status.classList.add("alert");
            appendTH(headerRow, "");
            appendTH(headerRow, "Test Case");
            appendTH(headerRow, "Test Input");
            appendTH(headerRow, "Your Output");
            appendTH(headerRow, "Details");
            
            var allPassed = true;
            var cases = response.results;
            for (var i = 0; i < cases.length; i++) {
                var row = tblBody.insertRow(i);
                row.className = cases[i].result;
            
                //display a checkmark or a x depeneding on success/failure
                row.insertCell(0).innerHTML = (cases[i].result == "success") ? '&#10003' : '&#10007';
                allPassed = allPassed && cases[i].result == "success";

                row.insertCell(1).appendChild(document.createTextNode(cases[i].title));

                row.insertCell(2).innerHTML = "<pre><code>" + cases[i].input + "</code></pre>"; 
                
                row.insertCell(3).innerHTML = "<pre><code>" + cases[i].output + "</code></pre>";
                
                //since we color the whole row, just make the cell contain the empty string
                if (!cases[i].err) cases[i].err = "";
                row.insertCell(4).appendChild(document.createTextNode(cases[i].err));
            }
            if(allPassed) {
                status.classList.add("alert-success");
                problemPassed = true;
            }
            else {
                status.innerHTML += ", but not all cases passed";
                status.classList.add("alert-warning");
            }
        }
        else if (response.status == "fail") {
            status.innerHTML = "Compile Error"; 
            status.classList.add("alert");
            status.classList.add("alert-danger");
            appendTH(headerRow, "Error");
            
            var errorRow = tblBody.insertRow(0);
            errorRow.className = "fail";
            errorRow.insertCell(0).innerHTML = "<pre><code>" + response.err + "</code></pre>";
        }
        result.appendChild(tbl);
        
        responseContainer.appendChild(status);
        responseContainer.appendChild(result);
        
    //  We only show modal on success
        if (problemPassed) 
            ShowSubmissionModal(MODAL_ID);
        else
            CopyModalContentsToPage();
    });
}

function SaveCode(){
    var code = editor.getValue();
    $.post(document.URL + '/save', {code: code, pageLoadTime: Math.trunc(pageLoadTime.getTime()/1000)}, function(response) {
        $('#save-success').fadeIn().delay(800).fadeOut();
    });
}

function LoadCode(){
    $.get(document.URL + '/load', {}, function(response) {
        editor.setValue(response.code);
        pageLoadTime = new Date(response.pageLoadTime * 1000);
    });
}