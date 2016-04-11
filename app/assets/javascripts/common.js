/**
 *  Common Javascript
 */

/**
 *  Any row (<tr>) with the 'clickable-row' class can be made into a link if
 *  'data-href' is provided as an attribute.
 *  This was taken from: https://stackoverflow.com/questions/25125076/how-to-make-tr-clickable-over-link-to
 */
$(document).on("click", ".clickable-row", function() {
    window.location = $(this).data("href");
});
/*  */