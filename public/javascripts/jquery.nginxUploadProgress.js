$.ajaxSetup({
    'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "application/json")}
});

jQuery.nginxUploadProgress = function(settings) {
  settings = jQuery.extend({
    interval: 2000,
    progress_bar_id: "progressbar",
    nginx_progress_url: "/progress"
  }, settings);

  $('#upload').submit( function() {
    $('#uploader').hide();
    $('#uploading').show();
    this.timer = setInterval(function() { 
      jQuery.nginxUploadProgressFetch(this, settings['nginx_progress_url'], settings['progress_bar_id'], settings['uuid']) 
    }, settings['interval']);
  })
};

jQuery.nginxUploadProgress.inum = 0;

jQuery.nginxUploadProgressFetch = function(e, nginx_progress_url, progress_bar_id, uuid) {
 // window.console.log("fetcing progress for "+uuid)
 jQuery.nginxUploadProgress.inum++;

 $.ajax({
   type: "GET",
   url: nginx_progress_url,
   dataType: "json",
   beforeSend: function(xhr) {
     xhr.setRequestHeader("X-Progress-ID", uuid);
     // window.console.log("setting headers: "+uuid)
   },
   complete: function(xhr, statusText) {
    // window.console.log("complete!: "+statusText);
   },
   success: function(upload) {
     /* change the width if the inner progress-bar */
     if (upload.state == 'uploading') {
       bar = $('#'+progress_bar_id);
       w = Math.floor((upload.received / upload.size)*100);
       bar.width(w + '%');

       // Panda specific
       bar.show();

       // Update ETA
       eta_seconds = ((upload.size / upload.received) * jQuery.nginxUploadProgress.inum) - jQuery.nginxUploadProgress.inum;

       if (eta_seconds < 60) {
         eta_str = "Moins d'une minute"
       } else if (eta_seconds < (60*5)) {
         eta_str = "encore quelque minute"
       } else if (eta_seconds < (60*15)) {
         eta_str = "15 minutes"
       } else if (eta_seconds < (60*30)) {
         eta_str = "30 minutes"
       } else if (eta_seconds < (60*45)) {
         eta_str = "45 minutes"
       } else if (eta_seconds < (60*60)) {
         eta_str = "un peu moins d'une heure"
       } else if (eta_seconds > (60*60)) {
         eta_str = "plus d'une heure";
       } else if (eta_seconds > (60*60*2)) {
         eta_str = "quelque heure";
       } else if (eta_seconds > (60*60*3)) {
         eta_str = "plusieurs heures";
       } else if (eta_seconds > (60*60*6)) {
         eta_str = "un très long temps... au moins 6 heures";
       }

       $("#eta").html(eta_str);
     }
   }
 });
};

