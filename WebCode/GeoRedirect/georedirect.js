var onSuccess = function(response) {
  var cCode = response.country.iso_code;
  var cContinent = response.continent.code;
  var uri = null,
      ukSite  = 'https://eu.peerless-av.com',
      geSite  = 'https://www.peerless-av.eu.com/de-de/ded_professional',
      frSite  = 'https://www.peerless-av.eu.com/fr-fr/professionnels',
      laSite  = 'https://mx.peerless-av.myshopify.com',
      usSite  = 'https://peerless-av.myshopify.com';
    console.log("response", response);
    console.log("cCode", cCode);

  switch (cCode) {
    case "DE":
    case "AT":
    case "LI":
    case "CH":
      uri = geSite;
      break;
    case "FR":
      uri = frSite;
      break;
    default:
      switch (cContinent) {
        case "NA":
        case "OC":
        case "SA":
          // uri = usSite;
          break;
        case "EU":
        case "AF":
        case "AN":
        case "AS":
          uri = ukSite;
          break;
        default:
          //uri = usSite;
          break;
      }
  }
  console.log("uri", uri);
  if (uri && localStorage.getItem('dev_team') == null) window.location = uri;
};

var onError = function(error) {
  console.log(JSON.stringify(error, undefined, 4));
  //window.location = uri;
};

if (typeof geoip2 !== "undefined") {
  geoip2.country(onSuccess, onError);
}
