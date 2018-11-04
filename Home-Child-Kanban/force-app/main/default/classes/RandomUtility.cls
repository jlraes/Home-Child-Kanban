public class RandomUtility {
    
    //method to return random value between 2 numbers
    public static Integer generateRandomFromRange(integer startNum, integer endNum){
        Integer returnValue;
        //Logic- first we will generate random boolean value which will decide if we want to
        //add the random number from startNum or will subtract random number from endNum
        Integer randomNumber = Integer.valueof((math.random() * 10));
        boolean addSubFlag= math.mod(randomNumber,2) == 0 ? true : false;
        
        integer diffInRange = endNum-startNum;
        //Now find random number staring from 0 to diffInRange
        Integer randomNum = Math.mod(Math.round(Math.random()*diffInRange+1),diffInRange);
        
        //If addSubFlag is true, we will add random number generated between 0 and diffInRange from start number
        //else we will subtract random number from end number
        if(addSubFlag){
            if(diffInRange > 1)
                returnValue =startNum + randomNum;
            else
                returnValue =startNum;
        }else{
            if(diffInRange > 1)
                returnValue = endNum - randomNum;
            else
                returnValue =endNum;
        }
        return returnValue;
    }
    
    //method to return random number between 0 and size-1
    public static Integer generateRandomNumber(Integer size){
        Decimal d = math.random() * size;
        return d.intValue();
    }
    
    //method to return boolean number randomly
    public static Boolean generateRandomBoolean(){
        integer randomNumber = Integer.valueof((math.random() * 10));
        boolean returnValue= math.mod(randomNumber,2) == 0 ? true : false;
        return returnValue;
    }
    //Finding a random string value from list of strings
    public static String selectRandomStringFromList(List<String> values){
        Integer randomNumber = generateRandomFromRange(0,values.size()-1);
        return values[randomNumber];
    }
    
    //Finding a random string value from list of strings
    public static List<String> selectRandomStringsFromList(List<String> values){
        Integer randomNumberOfStrings = generateRandomFromRange(0,values.size()-1);
        Integer randomNumber=0;
        String singleString='';
        List<String> listStrings = new List<String>();
        for (Integer i=0;i<randomNumberOfStrings;i++){
            randomNumber = generateRandomFromRange(0,values.size()-1);
            singleString = values[randomNumber] ;
            if (!listStrings.contains(singleString)) listStrings.add(singleString);
        }
        return listStrings;
    }
    
    public static List<String> getPickListSingle(String objectName, String pickListField){
        //to refactor
        List<String> allLabels = new List<String>();
        Schema.SObjectType sObj = Schema.getGlobalDescribe().get(objectName);
        Map<String, Schema.SObjectField> fieldResult_Map = new Map<String, Schema.SObjectField>();
        fieldResult_Map = sObj.getDescribe().fields.getMap();
        List<Schema.Picklistentry> pickListValueList =fieldResult_Map.get(pickListField).getDescribe().getpicklistValues();
        for(Schema.Picklistentry sch : pickListValueList){
            allLabels.add(sch.getLabel());
        }
        return allLabels; 
        // USE
        // List<String> someList = RandomUtility.getPickListSingle('objectName','pickListField');
        //System.debug(someList);
    }
    
    public static String getRandomPickListSingle(String objectName, String pickListField){
        List<String> listLabels = getPickListSingle(objectName, pickListField);
        String randomLabel = listLabels.Get(RandomUtility.generateRandomFromRange(0, listLabels.Size()-1));
        return randomLabel;
    }
    
    public static SObject getRandomSObjectFromList(List<SObject> listObjects){
        SObject thisObject = listObjects.get(RandomUtility.generateRandomFromRange(0, listObjects.Size()-1));
        return thisObject;
    }
    
}