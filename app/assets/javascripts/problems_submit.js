/* jshint browser:true, devel:true */
/* global $ */

/**
 * Created by kade on 4/10/16.
 * This is being included on all pages, even though it's only needed on one
 * this is harder to fix in rails than it should be
*/

function SubmitCode(code){
    //TODO load spinner
    //TODO xmlhttprequest
    $.get('/problems/evaluate', { code: code }, function(data) {
        var response = data.value;
        alert('server responded with ' + response);
    });
    //TODO render response
}