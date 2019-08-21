/**
 * Created by Alona Riabchenko on 02.10.2017.
 */

public with sharing class DataMaps {
    public static final String INCOMING_CALL = ' incoming-call';
    public static final String OUTGOING_CALL = ' outgoing-call';
    public static final String WEB_CALL = ' webcallback-call';

    @TestVisible
    private static List<String> labelList = new List<String>{
              Label.Status1
            , Label.Status2
            , Label.Status3
            , Label.Status4
            , Label.Status6
            , Label.Status7
            , Label.Status8
            , Label.Status9
            , Label.Status10
            , Label.Status11
            , Label.Status13
            , Label.Status14
            , Label.Status15
            , Label.Status16
            , Label.Status17
            , Label.Status18
            , Label.Status19
            , Label.Status20
            , Label.Status21
            , Label.Status25
            , Label.Status003
            , Label.StatusAgent1
            , Label.StatusAgent2
            , Label.StatusAgent3
            , Label.StatusAgent4
            , Label.StatusAgent6
            , Label.StatusAgent7
            , Label.StatusAgent8
            , Label.StatusAgent10
            , Label.StatusAgent11
            , Label.StatusAgent13
            , Label.StatusAgent14
            , Label.StatusAgent15
            , Label.StatusAgent16
            , Label.StatusAgent17
            , Label.StatusAgent18
            , Label.StatusAgent19
            , Label.StatusAgent20
            , Label.StatusAgent21
            , Label.StatusAgent25
    };
    public static Map<String, String> mapStatusClasses = new Map<String, String>{
            '1' => StatusManager.Status1.class.getName(),
            '2' => StatusManager.Status2.class.getName(),
            '7' => StatusManager.Status7.class.getName(),
            '8' => StatusManager.Status8.class.getName(),
            '13' => StatusManager.Status13.class.getName(),
            '14' => StatusManager.Status14.class.getName(),
            '16' => StatusManager.Status16.class.getName(),
            '18' => StatusManager.Status16.class.getName(),
            '25' => StatusManager.Status25.class.getName()
    };


    public static Set<String> allStatuses = new Set<String>{
            '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'
            , '13', '14', '15', '16', '17', '18', '19', '20', '21', '25'
    };

    public static Map<String, String> mapStatusCSSClasses = new Map<String, String>{
            '1' => INCOMING_CALL,
            '2' => OUTGOING_CALL,
            '3' => WEB_CALL
    };

    public static Map<String, String> mapStatuses = new Map<String, String>{
            '8' => INCOMING_CALL,
            '13' => OUTGOING_CALL
    };

    public static String getColor(String status) {
        if (mapStatusCSSClasses.containsKey(status)) {
            return mapStatusCSSClasses.get(status);
        } else {
            return '';
        }
    }


}