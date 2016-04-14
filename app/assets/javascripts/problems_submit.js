/* jshint browser:true, devel:true */
/* global $, pageLoadTime */

/**
 * Created by kade on 4/10/16.
 * This is being included on all pages, even though it's only needed on one
 * this is harder to fix in rails than it should be
*/

function ShowSubmissionModal(id) {
    $('#' + id).modal('show');
}

function SubmitCode(code, containerId){
    ShowSubmissionModal('submission-results-modal');
    
    var responseContainer = document.getElementById(containerId); 
    DeleteChildren(responseContainer);

    var loadingContainer = CreateElement('div', '', 'load-container');
    var spin = CreateElement('div', 'Loading...', 'loader');
    var loadingLabel = CreateElement('span', 'Evaluating...');

    loadingContainer.appendChild(spin);
    loadingContainer.appendChild(loadingLabel);
    responseContainer.appendChild(loadingContainer);

    $.get(document.URL + '/evaluate', { code: code, 
                                        time_submitted: Math.trunc(pageLoadTime.getTime()/1000),
                                        page_loaded_at: Math.trunc(new Date().getTime()/1000) 
                                      }, 
    function(response) {
        console.log(response);

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
            appendTH(headerRow, "Input");
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

                row.insertCell(2).appendChild(document.createTextNode(cases[i].input));
                
                //since we color the whole row, just make the cell contain the empty string
                if (!cases[i].err) cases[i].err = "";
                row.insertCell(3).appendChild(document.createTextNode(cases[i].err));
            }
            if(allPassed)
                status.classList.add("alert-success");
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
            errorRow.insertCell(0).appendChild(document.createTextNode(response.err));
        }
        result.appendChild(tbl);
        
        responseContainer.appendChild(status);
        responseContainer.appendChild(result);
    });

    
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
}