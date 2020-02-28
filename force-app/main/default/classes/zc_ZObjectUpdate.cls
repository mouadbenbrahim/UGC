public class zc_ZObjectUpdate implements zc_Zuc.MappedProperties { //zc_ZObject, 
    /**
     * 
     * @return id
     */
    public String id { get; set; }

    /**
     * Used to set a list of fields to null.\n
     * @return fieldsToNull
     */
    public List<String> fieldsToNull { get; set; }

    public String batch;
    public String tech_FlagRejetPaye;
    public String codeFinContrat;
    public Date dateFinContrat;
    public String operation;
    public String codeOffrePrincipale { get; set; }
    public String modeLivraison { get; set; }
    public String marche { get; set; }
    public String codePromo { get; set; }
    public String methodePaiement { get; set; }
    public String codeOffreCo { get; set; }
    public String payeurCRMID { get; set; }
    public String lieu { get; set; }
    public String agent { get; set; }
    public String typeContrat { get; set; }
    public String parrainSFID { get; set; }
    public String idContratPrecedent { get; set; }
    public Boolean autoPay { get; set; }
    public String defaultPaymentMethodId { get; set; }
    public String cancelCaseId { get; set; }
    public Date serviceActivationDate { get; set; }
    public Date contractAcceptanceDate { get; set; }
    public String status { get; set; }
    

    private final Map<String, String> propertyMappings = new Map<String, String>{
        'Id' => 'id',
        'Batch' => 'batch',
        'Tech_FlagRejetPaye__c' => 'tech_FlagRejetPaye',
        'CodeFinContrat__c' => 'codeFinContrat',
        'DateFinContrat__c' => 'dateFinContrat',
        'Operation__c' => 'operation',
        'CodeOffrePrincipale__c' => 'codeOffrePrincipale',
        'ModeLivraison__c' => 'modeLivraison',
        'Marche__c' => 'marche',
        'CodePromo__c' => 'codePromo',
        'MethodePaiement__c' => 'methodePaiement',
        'CodeOffreCo__c' => 'codeOffreCo',
        'PayeurCRMID__c' => 'payeurCRMID',
        'Lieu__c' => 'lieu',
        'Agent__c' => 'agent',
        'TypeContrat__c' => 'typeContrat',
        'ParrainSFID__c' => 'parrainSFID',
        'IdContratPrecedent__c' => 'idContratPrecedent',
        'AutoPay' => 'autoPay',
        'DefaultPaymentMethodId' => 'defaultPaymentMethodId',
        'CancelCaseID__c' => 'cancelCaseId',
        'ServiceActivationDate' => 'serviceActivationDate',
        'ContractAcceptanceDate' => 'contractAcceptanceDate',
        'Status' => 'status'
    };

    public Map<String, String> getPropertyMappings() {
        return propertyMappings;
    }

    public zc_ZObjectUpdate() {
        fieldsToNull = new List<String>();
    }

    // public static zc_ZObjectUpdate getExample() {
    //     zc_ZObjectUpdate zObjectUpdate = new zc_ZObjectUpdate();
    //     zObjectUpdate.id = 'aeiou';
    //     zObjectUpdate.fieldsToNull = new List<String>{'aeiou'};
    //     return zObjectUpdate;
    // }

    public Boolean equals(Object obj) {
        if (obj instanceof zc_ZObjectUpdate) {
            zc_ZObjectUpdate zObjectUpdate = (zc_ZObjectUpdate) obj;
            return this.id == zObjectUpdate.id
                && this.fieldsToNull == zObjectUpdate.fieldsToNull;
        }
        return false;
    }

    public Integer hashCode() {
        Integer hashCode = 43;
        hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
        hashCode = (17 * hashCode) + (fieldsToNull == null ? 0 : System.hashCode(fieldsToNull));
        return hashCode;
    }
}