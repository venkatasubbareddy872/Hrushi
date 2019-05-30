@isTest
public class FieldSetController_Test {
	
    @isTest static void testFieldSet() {
        FieldSetController.getTypeNames();        
        List<String> fieldSetNames = FieldSetController.getFieldSetNames('Account');
        Boolean hasFieldSets = FieldSetController.hasFieldSets('Account');
        System.assertEquals(true, hasFieldSets);
        FieldSetController.getFields('Account', fieldSetNames[0]);
        FieldSetMember fieldSet = new FieldSetMember(true);
    }
}