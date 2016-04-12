/* jshint browser:true, devel:true */
/* global $, pageLoadTime */

/**
 * Created by kade on 4/10/16.
 * This is being included on all pages, even though it's only needed on one
 * this is harder to fix in rails than it should be
*/



function SubmitCode(code, containerId){
    var responseContainer = document.getElementById(containerId); 
    DeleteChildren(responseContainer);

    var loadingContainer = CreateElement('div', '', 'load-container');
    var spin = CreateElement('div', 'Loading...', 'loader');
    var loadingLabel = CreateElement('span', 'Evaluating...');

    loadingContainer.appendChild(spin);
    loadingContainer.appendChild(loadingLabel);
    responseContainer.appendChild(loadingContainer);
    
    $.get(document.URL + '/evaluate', { code: code, 
                        startTimestamp: pageLoadTime.getTime(),
                        currentTimestamp: new Date().getTime(),
                                }, 
    function(response) {
        console.log(response);

        DeleteChildren(responseContainer);

        var status = CreateElement('div', '', 'submission-status');
        var result = CreateElement('div');
        var tbl = CreateElement('table', '', 'table');
        
        if (response.status == "success") {
            status.innerHTML = "Code Succesfully Evaluated";
            
            var cases = response.results;
            for (var i = 0; i < cases.length; i++) {
                var row = tbl.insertRow(i);
                row.className = cases[i].result;
            
                //display a checkmark or a x depeneding on success/failure
                row.insertCell(0).innerHTML = (cases[i].result == "success") ? '&#10003' : '&#10007';

                row.insertCell(1).appendChild(document.createTextNode(cases[i].title));

                row.insertCell(2).appendChild(document.createTextNode(cases[i].input));
                
                //since we color the whole row, just make the cell contain the empty string
                if (!cases[i].err) cases[i].err = "";
                row.insertCell(3).appendChild(document.createTextNode(cases[i].err));
            }
        }
        else if (response.status == "fail") {
            status.innerHTML = "Compile Error"; 
            var errorRow = tbl.insertRow(0);
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