/**
 * ClassName: FileContentSearcher
 * Purpose: This class will find specifed String in Filess Tab(ContentDocument)
 * 
 * 
 **/
public class FileContentSearcher {
    
    
    public static List<String> searchFilesContainingString(String searchString){
        List<String> fileNamesHavingString=new List<String>();
        List<ContentDocument> textTypeDocuments=[Select id,Title,FileExtension from ContentDocument where fileType='TEXT'];
        for(ContentDocument cd: textTypeDocuments){
            
            String downloadURL=getDownloadUrl(cd.id);
            if(downloadAndSearchFileContent(downloadURL,searchString)){
                fileNamesHavingString.add(cd.Title+'.'+cd.FileExtension);
                
            }
            
        }    
        return fileNamesHavingString;
    }
    
    private static String getDownloadUrl(String fileID){
        String fileURL='/services/data/v37.0/connect/files/'+fileID;
        HTTP http=new HTTP();
        HTTPRequest req=new HTTPRequest();
        req.setHeader('Authorization','Bearer '+UserInfo.getSessionID());
        req.setHeader('Content-Type','application/json');
        req.setHeader('accept','application/json');
        req.setMethod('GET');
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()+fileURL);
        
        HttpResponse resp = http.send(req);
        
        String downloadUrl=(String)((Map<String,Object>)Json.deserializeUntyped(resp.getBody())).get('downloadUrl');
        return downloadUrl;

    }
    
    private static boolean downloadAndSearchFileContent(String downloadUrl,String searchString){
        HTTP http=new HTTP();
        HTTPRequest req=new HTTPRequest();
        req.setHeader('Authorization','Bearer '+UserInfo.getSessionID());
        req.setHeader('Content-Type','application/json');
        req.setHeader('accept','application/json');
        req.setMethod('GET');
        req.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()+downloadUrl);
        
        HttpResponse resp = http.send(req);
        if(resp.getBody().containsIgnoreCase(searchString)){
            return true;
            
        }
        return false;
        
    }
    
}
