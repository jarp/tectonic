Tectonic = {

  handleError: function(response){
    console.log("error response is ", response)

    if ( response.status == 422 ){
      alert("You cannot do that.");
      console.log("422 error");
    }

    else {
      console.log("general error");
      wanna_see = confirm('An Error Occurred: ' + response.statusText)
      if ( wanna_see) {
        alert(response.responseText);
      }
    }
  }
}
