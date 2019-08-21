/**
 * Created by Valera on 19.09.2017.
 */

public with sharing class TokenResponseBody {

     public static String jsonTest = '{'+
            '	\"access_token\": \"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0dCI6IlRlc3RDb21wYW55IiwicHAiOiJ7XCJycGxcIjp7fX0iLCJjaSI6MjAwMDAsInNjb3BlIjpbInNhbGVzZm9yY2UtYXBpIl0sImV4cCI6MTUwNTE1NzY5NSwianRpIjoiMmI5MmE4ZjctNDc1Ny00MWIyLTg3MzgtYWQ1MDI1YmY5MzYyIiwiYXV0aG9yaXRpZXMiOlsiUk9MRV9TQUxFU0ZPUkNFIl0sImNsaWVudF9pZCI6Ijd5WTVSRUtzIn0.nzt72QYCiJ-qk8lSwRPx_9bmSDnsdTFKlY2ZMciOQnYvlfrE7ZkxcPLI4UJr0YHHYY9s5XcPiG6v-eqYmeYHJycxdU3VtHo6JdBtoy3-AWgU79ggeC6POM7gxHV65DXcNZ7cTR9cFpkN7tAYUmwtSgZC4d7VE48bhy5z0-ttSzwix4tGJTNccYZ7Jkx8lfDe5bIBK7j_rNhxvllGT4gGjGykAMXHMmP3y5FoljXnefc0GOlqEeOGPaMnQNJxTrR32r9t784r0itzZcgiCDGq4xRhQA009rxwmonDw2Rq9UAT-evsfrIByrUZSRY-w5zShBXU68KTKJzj5q7JIpR2RA\",'+
//            '	\"access_token\": \"\",'+
            '	\"token_type\": \"bearer\",'+
            '	\"expires_in\": 43199,'+
            '	\"scope\": \"salesforce-api\"'+
            '}';

        public String access_token;
        public String token_type;
        public Integer expires_in;
        public String scope;
//        public String error;

    public static TokenResponseBody parse(String json) {
        return (TokenResponseBody) System.JSON.deserialize(json, TokenResponseBody.class);
    }

}