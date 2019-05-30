/**
 * When sandboxes refresh, all users' email addresses have @example.com appended to them.
 * This is a safety feature to prevent unexpected or unwanted emails to be sent from sandbox to users.
 * This class reverts all active users' email addresses by removing the @example.com.
 */
public with sharing class RevertUserEmailsBatchable implements Database.Batchable<SObject> {

    public Database.QueryLocator start( Database.BatchableContext context ) {
        Set<String> profileNames = new Set<String> { 'System Administrator', 'Inside Sales Manager',
                                                     'Pardot Connection', 'Sys Admin with Gainsight view','Growth Ops Admin'};
        return Database.getQueryLocator( 'SELECT id, email FROM User WHERE Profile.Name IN : profileNames AND isActive = true' );
    }

    public void execute( Database.BatchableContext context, List<User> users ) {

        for ( User u : users ) {

            System.debug( 'user sandbox email: ' + u.email );

            u.email = u.email.replace('@example.com', '').replace('=', '@');

            System.debug( 'user reverted email: ' + u.email );

        }

        update users;

    }

    public void finish( Database.BatchableContext context ) {

    }

}