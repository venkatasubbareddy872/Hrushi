@isTest
class PrepareSandboxTest {

    @isTest
    static void testMySandboxPrep() {
        // Insert logic here to create records of the objects that the class you’re testing
        // manipulates.

        Test.startTest();

        Test.testSandboxPostCopyScript(
            new PrepareSandbox(), UserInfo.getOrganizationId(),
                UserInfo.getOrganizationId(), UserInfo.getOrganizationName());

        Test.stopTest();

        // Insert assert statements here to check that the records you created above have
        // the values you expect.
    }
}