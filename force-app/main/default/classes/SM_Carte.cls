/**
 * Created by mouad on 03/09/2018.
 */

public with sharing class SM_Carte {

    public SM_Carte(){}
    
    
    @Future(callout=true) 
    public static void desactivationByListAsynchrone(set<Id> setAccountId, String code) {
        map<Id, Boolean> desactivationResult = desactivationByList(setAccountId, code);
        system.debug ('##MNE SM_Carte desactivationByListAsynchrone desactivationResult >> '+desactivationResult); 
    }
        
    
    public static map<Id, Boolean> desactivationByList(set<Id> setAccountId, String code) {
        system.debug('##MNE SM_Carte desactivationByList setAccountId >> '+setAccountId);
        system.debug('##MNE SM_Carte desactivationByList code >> '+code);
        map<Id, Boolean> listResultByCarteId = new map<Id, Boolean>();
        
        if(setAccountId == null || setAccountId.size() == 0){
            system.debug('##MNE SM_Carte desactivationByList setAccountId empty');
            return listResultByCarteId;
        }
        
        list<Carte__c> listCarte = new list<Carte__c>([SELECT Id, Abonn__c, Name, Statut__c FROM Carte__c WHERE Statut__c = 'Active' AND Abonn__c IN :setAccountId]);
        if(listCarte.size() == 0){
            return listResultByCarteId;
        }
        
        list<Carte__c> listCarteToUpdate =  new list<Carte__c>();
        for(Carte__c c : listCarte){
            try{
                deactivateCard(c.Name, code);
                c.Statut__c = 'Inactive';
                listCarteToUpdate.add(c);
                listResultByCarteId.put(c.Id, true);
            }catch(Exception e){
                system.debug('##MNE SM_Carte desactivationByList exception >> '+e.getMessage());
                listResultByCarteId.put(c.Id, false);
            }
        }
        
        if(listCarteToUpdate.size() > 0){
            update listCarteToUpdate;
        }
        
        system.debug('##MNE SM_Carte desactivationByList END');
        return listResultByCarteId;
    }


    public static map<Id, Boolean> desactivation(Id accountId, String code) {
        system.debug('##MNE SM_Carte desactivation accountId >> '+accountId);
        system.debug('##MNE SM_Carte desactivation code >> '+code);
        map<Id, Boolean> listResultByCarteId = new map<Id, Boolean>();
        
        if(accountId == null){
            system.debug('##MNE SM_Carte desactivation accountId empty');
            return listResultByCarteId;
        }
        
        list<Carte__c> listCarte = new list<Carte__c>([SELECT Id, Abonn__c, Name, Statut__c FROM Carte__c WHERE Statut__c = 'Active' AND Abonn__c = :accountId]);
        if(listCarte.size() == 0){
            return listResultByCarteId;
        }
        
        list<Carte__c> listCarteToUpdate =  new list<Carte__c>();
        for(Carte__c c : listCarte){
            try{
                deactivateCard(c.Name, code);
                c.Statut__c = 'Inactive';
                listCarteToUpdate.add(c);
                listResultByCarteId.put(c.Id, true);
            }catch(Exception e){
                system.debug('##MNE SM_Carte desactivation exception >> '+e.getMessage());
                listResultByCarteId.put(c.Id, false);
            }
        }

        if(listCarteToUpdate.size() > 0){
            update listCarteToUpdate;
        }
        
        system.debug('##MNE SM_Carte desactivation END');
        return listResultByCarteId;
    }


    public static void activation(String code) {

        // Call WS Cardwizard

        // Create update SF Carte object

    }

    public static WSZ.CarteOut get(Integer mId) {
        String endpoint = 'https://xmlresa.ugc.fr/CardwizardAPI_dev/api/Carte?CardID=' + mId;
        String method = 'GET';
        String wsIn = null;
        String wsOut = '';

        // Retrieve Zuora token
        //String accessToken = WS002_Cardwizard.access_token;

        //wsIn = (String) JSON.serialize(sub);
        System.debug('##MBEN: wsIn |' + wsIn + '|');
        wsOut = WS002_Cardwizard.sendRequest(endpoint, method, wsIn);
        System.debug('##MBEN: wsOut |' + wsOut + '|');
        return (WSZ.CarteOut) JSON.deserializeStrict(wsOut, WSZ.CarteOut.class);
    }

    public static WSZ.CarteOut add(Boolean Activer, String CardID, String DebutValidite, String FinValidite, String DernierNumero) {

        String endpoint = 'https://xmlresa.ugc.fr/CardwizardAPI_dev/api/Carte/Money2?activer=' + Activer;
        String method = 'POST';
        String wsIn = null;
        String wsOut = '';

        // Retrieve Zuora token
        //String accessToken = WS002_Cardwizard.access_token;
        WSZ.CarteAddIn wsInObj = new WSZ.CarteAddIn();
        wsInObj.CardID = CardID;
        wsInObj.DebutValidite = DebutValidite;
        wsInObj.FinValidite = FinValidite;
        wsInObj.DernierNumero = DernierNumero;
        wsInObj.DateCle = DebutValidite;
        wsInObj.CardSubType = 3;
        wsInObj.Reference = 0;

        //Messages erreurs:
        //{"Message":"La demande n’est pas valide.","ModelState":{"carte.Reference":["Error converting value {null} to type 'System.Int32'. Path 'Reference', line 1, position 17."],"carte.DateCle":["Error converting value {null} to type 'System.DateTime'. Path 'DateCle', line 1, position 160."],"carte.CardSubType":["Error converting value {null} to type 'System.Int32'. Path 'CardSubType', line 1, position 179.","The field CardSubType must be between 1 and 2147483647."]}}
        //{"Message":"Une erreur s’est produite.","ExceptionMessage":"Veuillez utiliser la fonction AjouterCarteAsync pour ce numéro de carte","ExceptionType":"System.ArgumentException","StackTrace":"   at UGC.Cardwizard.API.Carte.CarteApi.<AjouterCartesMoney2Async>d__1.MoveNext() in C:\\vsts\\_work\\45\\s\\CardwizardAPI\\src\\CardwizardAPI.Lib\\Api\\Carte\\CarteApi_Operations.cs:line 115\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at UGC.Cardwizard.API.Controllers.CarteController.<AjouterCarteMoney2Async>d__8.MoveNext() in C:\\vsts\\_work\\45\\s\\CardwizardAPI\\src\\CardwizardAPI\\Controllers\\CarteController.cs:line 135\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at System.Threading.Tasks.TaskHelpersExtensions.<CastToObject>d__3`1.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at System.Web.Http.Tracing.ITraceWriterExtensions.<TraceBeginEndAsyncCore>d__18`1.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at System.Web.Http.Controllers.ApiControllerActionInvoker.<InvokeActionAsyncCore>d__0.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at System.Web.Http.Tracing.ITraceWriterExtensions.<TraceBeginEndAsyncCore>d__18`1.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at System.Web.Http.Controllers.ActionFilterResult.<ExecuteAsync>d__2.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at System.Web.Http.Controllers.ExceptionFilterResult.<ExecuteAsync>d__0.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Web.Http.Controllers.ExceptionFilterResult.<ExecuteAsync>d__0.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at System.Web.Http.Tracing.Tracers.HttpControllerTracer.<ExecuteAsyncCore>d__5.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at System.Web.Http.Tracing.ITraceWriterExtensions.<TraceBeginEndAsyncCore>d__18`1.MoveNext()\r\n--- End of stack trace from previous location where exception was thrown ---\r\n   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()\r\n   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)\r\n   at System.Web.Http.Dispatcher.HttpControllerDispatcher.<SendAsync>d__1.MoveNext()"}


        wsIn = (String) JSON.serialize(wsInObj);
        System.debug('##MBEN: wsIn |' + wsIn + '|');
        wsOut = WS002_Cardwizard.sendRequest(endpoint, method, wsIn);
        System.debug('##MBEN: wsOut |' + wsOut + '|');
        return (WSZ.CarteOut) JSON.deserializeStrict(wsOut, WSZ.CarteOut.class);
    }
    
    
    
    public static void processTriggerAfterInsert (List<Carte__c> listCartes)  { 
        createFileImpressionRecords (listCartes);
    }
    
    public static void createFileImpressionRecords (List<Carte__c> listCartes)  { 
        if(listCartes == null || listCartes.size() == 0){
            return;
        }
        set<Id> setCarteId = new set<Id>();
        for(Carte__c c : listCartes){
            setCarteId.add(c.Id);
        }

        list<File_Impression__c> listFileImpressionToIsert = new list<File_Impression__c>();
        map<Id, Carte__c> mapCarteById = new map<Id, Carte__c> ([SELECT Id, DemandeClient__c, DemandeClient__r.Subscription__c FROM Carte__c WHERE Id IN :setCarteId]);
        
        for(Carte__c c : listCartes){
            File_Impression__c fi   = new File_Impression__c();
            if(mapCarteById.containsKey(c.Id) && mapCarteById.get(c.Id).DemandeClient__r.Subscription__c != null){
                fi.Subscription__c  = mapCarteById.get(c.Id).DemandeClient__r.Subscription__c;
            }
            //fi.Subscription__c      = c.Contrat__c;
            fi.Name                 = c.Name;
            fi.Account__c           = c.Abonn__c;
            fi.IsCarte__c           = true;
            fi.Carte__c             = c.Id;
            fi.Case__c              = c.DemandeClient__c;
            fi.Statut__c            = 'A Imprimer';
            listFileImpressionToIsert.add(fi);
        }

        if(listFileImpressionToIsert.size() > 0){
            insert listFileImpressionToIsert;
        }
    }
    
    public static Boolean activateCard(String numCard){
        system.debug('##MNE SM_Carte activateCard numCard >> '+numCard);
     
        if(String.isBlank(numCard)) {
            system.debug('##MNE SM_Carte activateCard numCard is Blank');
            throw new MyException('SM_Carte activateCard impossible : numCard is Blank');
        }

        String endpoint = '/card/activate?card_id='+numCard+'&reason=';

        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:OctopusAPI'+endpoint);
        req.setMethod('GET');
        req.setCompressed(true);
        req.setTimeout(60000);
            
        HttpResponse res = h.send(req);
        Boolean isOk = false;
        String body = res.getBody();
        String status = res.getStatus();
        system.debug('##MNE SM_Carte deactivate body >> '+body);
        system.debug('##MNE SM_Carte activateCard status >> '+status);
        if(status == 'OK'){
            isOk = true;
        } else{
            system.debug('##MNE SM_Carte activateCard pb dans l\'activation de la carte via Octopus');
            throw new MyException('SM_Carte activateCard impossible : problèmeb dans le WS Octopus');
        }
        system.debug('##MNE SM_Carte activateCard isOk >> '+isOk);
        return isOk;
    }
    
    public static Boolean deactivateCard(String numCard, String reason){
        system.debug('##MNE SM_Carte deactivateCard numCard >> '+numCard);
        system.debug('##MNE SM_Carte deactivateCard reason >> '+reason);
     
        if(String.isBlank(numCard)) {
            system.debug('##MNE SM_Carte deactivateCard numCard is Blank');
            throw new MyException('SM_Carte deactivateCard impossible : numCard is Blank');
        }
        /*if(String.isBlank(reason)) {
            system.debug('##MNE SM_Carte deactivateCard reason is Blank');
            throw new MyException('SM_Carte deactivateCard impossible : reason is Blank');
        }*/

        String endpoint = '/card/deactivate?card_id='+numCard+'&reason='+reason;

        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:OctopusAPI'+endpoint);
        req.setMethod('GET');
        req.setCompressed(true);
        req.setTimeout(60000);
            
        HttpResponse res = h.send(req);
        Boolean isOk = false;
        String body = res.getBody();
        String status = res.getStatus();
        system.debug('##MNE SM_Carte deactivate body >> '+body);
        system.debug('##MNE SM_Carte deactivate status >> '+status);
        if(status == 'OK'){
            isOk = true;
        } else{
            system.debug('##MNE SM_Carte deactivate pb dans la deactivate de la carte via Octopus');
            throw new MyException('SM_Carte deactivate impossible : problèmeb dans le WS Octopus');
        }
        system.debug('##MNE SM_Carte deactivate isOk >> '+isOk);
        return isOk;
    }
    
    private class MyException extends Exception {
    }

}