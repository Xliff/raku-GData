/*
  List created from the output of:
    ( find . -name \*.h -exec grep -Hn 'typedef struct'} \; 1>&2 ) 2>&1 | \
       cut -d\  -f 4 | grep -v \{
*/

/* Strategy provided by p6-XML-LibXML:author<FROGGS> */
#ifdef _WIN32
#define DLLEXPORT __declspec(dllexport)
#else
#define DLLEXPORT extern
#endif

#include <gdata/gdata.h>

#define s(name)     DLLEXPORT int sizeof_ ## name () { return sizeof(name); }

//s(BatchOperation)
s(GDataAccessRule)
s(GDataAPPCategories)
//s(GDataAsyncProgressClosure)
//s(GDataAsyncTestData)
s(GDataAuthor)
s(GDataAuthorizationDomain)
//s(GDataBatchFeed)
s(GDataBatchOperation)
//s(GDataBuffer)
s(GDataCalendarAccessRule)
s(GDataCalendarCalendar)
s(GDataCalendarEvent)
s(GDataCalendarFeed)
s(GDataCalendarQuery)
s(GDataCalendarService)
s(GDataCategory)
s(GDataColor)
s(GDataComment)
s(GDataDocumentsAccessRule)
s(GDataDocumentsDocument)
s(GDataDocumentsDrawing)
s(GDataDocumentsEntry)
s(GDataDocumentsFeed)
s(GDataDocumentsFolder)
s(GDataDocumentsMetadata)
s(GDataDocumentsPdf)
s(GDataDocumentsPresentation)
s(GDataDocumentsProperty)
s(GDataDocumentsQuery)
s(GDataDocumentsService)
s(GDataDocumentsSpreadsheet)
s(GDataDocumentsText)
s(GDataDocumentsUploadQuery)
s(GDataDownloadStream)
//s(GDataDummyAuthorizer)
s(GDataOAuth2Authorizer)
s(GDataEntry)
//s(GDataExifTags)
s(GDataFeed)
s(GDataGContactCalendar)
s(GDataGContactEvent)
s(GDataGContactExternalID)
s(GDataGContactJot)
s(GDataGContactLanguage)
s(GDataGContactRelation)
s(GDataGContactWebsite)
s(GDataGDEmailAddress)
//s(GDataGDFeedLink)
s(GDataGDIMAddress)
s(GDataGDName)
s(GDataGDOrganization)
s(GDataGDPhoneNumber)
s(GDataGDPostalAddress)
s(GDataGDReminder)
s(GDataGDWhen)
s(GDataGDWhere)
s(GDataGDWho)
s(GDataGenerator)
//s(GDataGeoRSSWhere)
//s(GDataGoaAuthorizer)
s(GDataLink)
s(GDataMediaCategory)
s(GDataMediaContent)
s(GDataMediaCredit)
//s(GDataMediaGroup)
s(GDataMediaThumbnail)
s(GDataParsable)
s(GDataPicasaWebAlbum)
s(GDataPicasaWebComment)
s(GDataPicasaWebFeed)
s(GDataPicasaWebFile)
s(GDataPicasaWebQuery)
s(GDataPicasaWebService)
s(GDataPicasaWebUser)
s(GDataQuery)
s(GDataService)
s(GDataTasksQuery)
s(GDataTasksService)
s(GDataTasksTask)
s(GDataTasksTasklist)
s(GDataUploadStream)
s(GDataYouTubeCategory)
s(GDataYouTubeComment)
s(GDataYouTubeFeed)
s(GDataYouTubeQuery)
s(GDataYouTubeService)
s(GDataYouTubeState)
s(GDataYouTubeVideo)
