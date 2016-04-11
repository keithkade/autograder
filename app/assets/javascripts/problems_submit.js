/* jshint browser:true, devel:true */
/* global $ */

/**
 * Created by kade on 4/10/16.
 * This is being included on all pages, even though it's only needed on one
 * this is harder to fix in rails than it should be
*/

function CreateElement(tagname, content){
    var elem = document.createElement(tagname);
    elem.innerHTML = content;
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

function SubmitCode(code, id){
    //TODO load spinner
    $.get('/problems/evaluate', { code: code }, function(data) {
        
        //TODO render response
        var responseContainer = document.getElementById(id);
        DeleteChildren(responseContainer);
        
        var status = CreateElement('div', 'Code Submitted');
        responseContainer.appendChild(status);
        
        var response = CreateElement('div', JSON.stringify(data));
        responseContainer.appendChild(response);
    });
}