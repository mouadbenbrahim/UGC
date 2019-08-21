global class TestHttpCalloutMock implements HttpCalloutMock{
	global Integer counter = 0;
	
	private Integer statusCode;
	private String status;
    
    global Boolean respond = true;
	
	global TestHttpCalloutMock() {
		statusCode = 200;
		status = 'OK';
	}
	
	global TestHttpCalloutMock(Integer code, String status) {
		this.statusCode = code;
		this.status = status;
	}
	
	global HttpResponse respond(HTTPRequest req){
		++counter;
        if(respond) {
            HttpResponse res = new HttpResponse();
            res.setStatus(status);
            res.setStatusCode(statusCode);
            res.setBody('Mocked Response Body');
            return res;
        } else {
			CalloutException e = new CalloutException();
            e.setMessage('This is a constructed exception!');
            throw e;
        }
		
	}
    
}