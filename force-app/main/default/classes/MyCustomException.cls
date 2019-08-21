/**
 * Created by Valera on 19.09.2017.
 */
public with sharing class MyCustomException extends Exception{
	public Object objWithError{get;set;}
}