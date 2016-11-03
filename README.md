# ApexFileSearcher
To search Text files with content which is not provided by standard salesforce functionality.

To use just pass the search string.

        List<String> fileNames=FileContentSearcher.searchFilesContainingString('Hello');
        System.debug(fileNames);
        
*****Do make sure you keep your instance url into remote site settings else it wont work******.
